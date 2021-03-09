Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8296332373
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 11:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCIK5h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 05:57:37 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:62952 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhCIK52 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 05:57:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615287448; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hi8Dchud9oBdFIrkBkCAoc6TTQnE4IpgjUOM0nIK/S0=; b=rIG+NLqg/FI+AYPLig1oUii7E8E4r09N2lBXbfqKEJMBQSZEemAHCW8WzYZANDi/1qFxX0YA
 wD/cUhWd6qLx3NdqazNo9zCwyLFaq3aseSGXA/1TZU9CkeMqPu6IlvBzWVPnd5xyOliIXm8x
 Mc/5X9JYCmstbQ/uUNgVr7/XmAA=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 604754986df184e952c1fb55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 10:57:28
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA097C433ED; Tue,  9 Mar 2021 10:57:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7EEEC433C6;
        Tue,  9 Mar 2021 10:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7EEEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH V5 1/2] ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
References: <20210222192651.1782-1-alokad@codeaurora.org>
        <20210222192651.1782-2-alokad@codeaurora.org>
Date:   Tue, 09 Mar 2021 12:57:23 +0200
In-Reply-To: <20210222192651.1782-2-alokad@codeaurora.org> (Aloka Dixit's
        message of "Mon, 22 Feb 2021 11:26:50 -0800")
Message-ID: <87sg54zjak.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> writes:

> From: John Crispin <john@phrozen.org>
>
> These calls are used for debugging and will be required for WFA
> certification tests.
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>

[...]

> +int ath11k_wmi_send_twt_add_dialog_cmd(struct ath11k *ar,
> +				       struct wmi_twt_add_dialog_params *params)
> +{
> +	struct ath11k_pdev_wmi *wmi = ar->wmi;
> +	struct ath11k_base *ab = wmi->wmi_ab->ab;
> +	struct wmi_twt_add_dialog_params_cmd *cmd;
> +	struct sk_buff *skb;
> +	int ret, len;
> +
> +	len = sizeof(*cmd);
> +
> +	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	cmd = (struct wmi_twt_add_dialog_params_cmd *)skb->data;
> +	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TWT_ADD_DIALOG_CMD) |
> +			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
> +
> +	cmd->vdev_id = params->vdev_id;
> +	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
> +	cmd->dialog_id = params->dialog_id;
> +	cmd->wake_intvl_us = params->wake_intvl_us;
> +	cmd->wake_intvl_mantis = params->wake_intvl_mantis;
> +	cmd->wake_dura_us = params->wake_dura_us;
> +	cmd->sp_offset_us = params->sp_offset_us;
> +	cmd->flags = params->twt_cmd;
> +	if (params->flag_bcast)
> +		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_BCAST;
> +	if (params->flag_trigger)
> +		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_TRIGGER;
> +	if (params->flag_flow_type)
> +		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_FLOW_TYPE;
> +	if (params->flag_protection)
> +		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_PROTECTION;
> +
> +	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
> +		   "WMI add TWT dialog, vdev %u, dialog id %u,\n"
> +		   "wake interval %u, mantissa %u, wake duration %u,\n"
> +		   "service period offset %u, flags 0x%x\n",

In debug messages please use all lower case, and no commas nor \n (ie.
all in one line).

> +	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_ADD_DIALOG_CMDID);
> +
> +	if (ret) {
> +		ath11k_warn(ab,
> +			    "Failed to send WMI command to add TWT dialog\n");

Warning and error messages should follow style:

"failed to send add TWT dialog WMI command: %d", ret

> +static void ath11k_wmi_twt_add_dialog_event(struct ath11k_base *ab,
> +					    struct sk_buff *skb)
> +{
> +	const char *status[] = {
> +		"OK", "TWT_NOT_ENABLED", "USED_DIALOG_ID", "INVALID_PARAM",
> +		"NOT_READY", "NO_RESOURCE", "NO_ACK", "NO_RESPONSE",
> +		"DENIED", "UNKNOWN_ERROR"
> +	};
> +	const void **tb;
> +	const struct wmi_twt_add_dialog_event *ev;
> +	int ret;
> +
> +	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
> +	if (IS_ERR(tb)) {
> +		ret = PTR_ERR(tb);
> +		ath11k_warn(ab,
> +			    "failed to parse TWT add dialog status event tlv: %d\n", ret);
> +		return;
> +	}
> +
> +	ev = tb[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT];
> +	if (!ev) {
> +		ath11k_warn(ab, "failed to fetch TWT add dialog event\n");
> +		goto exit;
> +	}
> +
> +	ath11k_dbg(ab, ATH11K_DBG_WMI,
> +		   "TWT Add Dialog Event - vdev: %d, dialog id: %d, status: %s\n",
> +		   ev->vdev_id, ev->dialog_id, status[ev->status]);

You are not checking that status array is not used out of bounds. I
would just remove the string conversion to keep things simple, but if
you want to print in strings please add a helper function to do the
conversion and add status values as enum to wmi.h.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
