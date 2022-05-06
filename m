Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2236551D164
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 08:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbiEFGgi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 02:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiEFGgh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 02:36:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB095EBDA
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 23:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0413FB83341
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 06:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB70CC385AA;
        Fri,  6 May 2022 06:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651818773;
        bh=td6aIKeZS3fL2oBY4q7hlIvKyZu+yRY4seDjYhJ0BaA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Kj7Gv3XE2JkJVwQUwCLzWzl55ambMzYx/aPMtu/QjwgWPRYbEwbMWr6yXcS7ungUD
         4ogIxrltOOsNmDiy8PX53CKbdQ5V5Zll/PZwxH4wpj3Q49N85cPyd1c14B/pMu2FIp
         SV9uIQslDleIPrnO6B/fEyBzhlx9U1y7xJ07mEt62Ycgh+hjDyKlYJRBXYR+fi140+
         xV8mVXc781Ytz0r0FuvjkPxN+YfgeWN249YB7q7oaKA+uvWo8YZPX257tkTspiRP7E
         WP/1SLhiI6h8iJsgCzGQpjYVRVuxhKtkIOYbNkdNe6UbYAb0v3uiRppFMfWsIaysPt
         tZFT+dIHxR8CA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] ath11k: Handle keepalive during WoWLAN suspend and resume
References: <20220506012540.1579604-1-quic_bqiang@quicinc.com>
Date:   Fri, 06 May 2022 09:32:49 +0300
In-Reply-To: <20220506012540.1579604-1-quic_bqiang@quicinc.com> (Baochen
        Qiang's message of "Fri, 6 May 2022 09:25:40 +0800")
Message-ID: <87fsln9nn2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> With WoWLAN enabled and after sleeping for a rather long time,
> we are seeing that with some APs, it is not able to wake up
> the STA though the correct wake up pattern has been configured.
> This is because the host doesn't send keepalive command to
> firmware, thus firmware will not send any packet to the AP and
> after a specific time the AP kicks out the STA.
>
> Fix this issue by enabling keepalive before going to suspend
> and disabling it after resume back.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

[...]

> +int ath11k_wmi_sta_keepalive(struct ath11k *ar,
> +			     const struct wmi_sta_keepalive_arg *arg)
> +{
> +	struct ath11k_pdev_wmi *wmi = ar->wmi;
> +	struct wmi_sta_keepalive_cmd *cmd;
> +	struct wmi_sta_keepalive_arp_resp *arp;
> +	struct sk_buff *skb;
> +	size_t len;
> +
> +	len = sizeof(*cmd) + sizeof(*arp);
> +	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_sta_keepalive_cmd *)skb->data;
> +	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
> +				     WMI_TAG_STA_KEEPALIVE_CMD) |
> +				     FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
> +	cmd->vdev_id = arg->vdev_id;
> +	cmd->enabled = arg->enabled;
> +	cmd->interval = arg->interval;
> +	cmd->method = arg->method;
> +
> +	if (arg->method == WMI_STA_KEEPALIVE_METHOD_UNSOLICITED_ARP_RESPONSE ||
> +	    arg->method == WMI_STA_KEEPALIVE_METHOD_GRATUITOUS_ARP_REQUEST) {
> +		arp = (struct wmi_sta_keepalive_arp_resp *)(cmd + 1);
> +		arp->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_STA_KEEPALVE_ARP_RESPONSE) |
> +				 FIELD_PREP(WMI_TLV_LEN, sizeof(*arp) - TLV_HDR_SIZE);

This added a new warning:

drivers/net/wireless/ath/ath11k/wmi.c:8989: line length of 94 exceeds 90 columns

I fixed it in the pending branch, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
