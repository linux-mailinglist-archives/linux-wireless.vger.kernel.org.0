Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870117230A3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 22:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFEUE3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFEUE1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 16:04:27 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5441D98
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 13:04:26 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0E04F30007D
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 20:04:23 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 31EE813C2B0
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 13:04:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 31EE813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1685995463;
        bh=yPgCuSvnLSqb7OIPxGB/VA7f+ca3AtL9yUkGf+burFQ=;
        h=Date:To:From:Subject:From;
        b=cbEG7cc/OxYvSwJ9mtn+1dSexjP86bS6Owh5/1yTaX33+SQBLwaI1jFgP6T5kzd7X
         KfXbh5KXF+iqb/YALbB4dDmJHESUcLWmmMGaoiNjBC3bbs6mL8zFMkWx05/hQiNGlf
         h0f9ix7JZ+2naMxh7f5we/fMYaqwALiWZIlht668=
Message-ID: <f8416cc9-6601-8c98-2a15-8ac5882833ce@candelatech.com>
Date:   Mon, 5 Jun 2023 13:04:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlwifi query on iwl_mvm_skb_prepare_status
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1685995464-EswvW5p8e0nK
X-MDID-O: us5;at1;1685995464;EswvW5p8e0nK;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I think the two memsets below access the same memory since skb_info
contains a union?  So maybe only one is needed?

static void iwl_mvm_skb_prepare_status(struct sk_buff *skb,
				       struct iwl_device_tx_cmd *cmd)
{
	struct ieee80211_tx_info *skb_info = IEEE80211_SKB_CB(skb);

	memset(&skb_info->status, 0, sizeof(skb_info->status));
	memset(skb_info->driver_data, 0, sizeof(skb_info->driver_data));

	skb_info->driver_data[1] = cmd;
}

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

