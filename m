Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C125EB164
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 21:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIZTdn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 15:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIZTdm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 15:33:42 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A999E68C
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 12:33:40 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.166])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 725F62A0073
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 19:33:39 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 48A3090007E
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 19:33:39 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id C735513C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 12:33:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C735513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1664220818;
        bh=Nid3DgXtW9vcP0LBrx+DrRdZnWKpQ9uzG3qdg2ASEHo=;
        h=To:From:Subject:Date:From;
        b=h6CaRECpH4ndSGR7lEE7+B3qMpH3ZwOyCzxwKlS542SvBk5+hhabXP1ER+darG/F3
         uAItUUsSvKKNYvtcXQ4fuBFC3AnqfpSV0adT+zyl6pngoVVi3s1K82IuXCspPTyuwR
         sIWbwVFOi3R2ewSLiO3RgA+jxGR/8aMPYCkODkHc=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlmvm potential issue in txpath
Organization: Candela Technologies
Message-ID: <1824eca9-4f41-b349-c91f-dc2561126d90@candelatech.com>
Date:   Mon, 26 Sep 2022 12:33:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1664220819-ULgkezikQvrs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I'm trying to track down a use-after-free and similar bugs in ax210...

 From looking at this code, I am thinking maybe this is part of the problem:

When this code returns non-zero, the skb is freed by calling code.

But in the section with #### HERE #### below, I think it could free
skb and still return != 0, which would cause double-free?

int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
		       struct ieee80211_sta *sta)
{
	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
	struct ieee80211_tx_info info;
	struct sk_buff_head mpdus_skbs;
	unsigned int payload_len;
	int ret;

	if (WARN_ON_ONCE(!mvmsta))
		return -1;

	if (WARN_ON_ONCE(mvmsta->sta_id == IWL_MVM_INVALID_STA))
		return -1;

	memcpy(&info, skb->cb, sizeof(info));

	if (!skb_is_gso(skb))
		return iwl_mvm_tx_mpdu(mvm, skb, &info, sta);

	payload_len = skb_tail_pointer(skb) - skb_transport_header(skb) -
		tcp_hdrlen(skb) + skb->data_len;

	if (payload_len <= skb_shinfo(skb)->gso_size)
		return iwl_mvm_tx_mpdu(mvm, skb, &info, sta);

	__skb_queue_head_init(&mpdus_skbs);

	ret = iwl_mvm_tx_tso(mvm, skb, &info, sta, &mpdus_skbs);
	if (ret)
		return ret;

	if (WARN_ON(skb_queue_empty(&mpdus_skbs)))
		return ret;

	while (!skb_queue_empty(&mpdus_skbs)) {
		skb = __skb_dequeue(&mpdus_skbs);

		ret = iwl_mvm_tx_mpdu(mvm, skb, &info, sta);
		if (ret) {

#### HERE ####
			__skb_queue_purge(&mpdus_skbs);
			return ret;
		}
	}

	return 0;
}


Maybe return 0 in that error branch?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

