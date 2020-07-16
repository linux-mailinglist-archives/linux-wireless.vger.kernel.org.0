Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B626A221DA2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 09:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgGPHvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 03:51:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58436 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPHvU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 03:51:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594885879; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=QJNHF8nSyL3KpP3Qe0q4cbzU3goLbrqVRld3h8n0nHk=; b=YlI4ovF7xVSJSQlh/fDCkBU4OBOxlb8FjqDRfPA9HQQEo06JGW8VNt9LD7tCJR2Q0MmQPj2X
 EMr7qd3Knqy0SOQ4MHs/pvTEYHu3DDt7hd0Zp/0JiaVkoyoGinyWhZQ7BhKhv6fSQB1RkqWe
 O0XYRZrZgzqbd1FD598PYrRXB/E=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f1006d4c9bd2efa2e1d4160 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 07:50:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68C3CC433C6; Thu, 16 Jul 2020 07:50:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14E9FC433C9;
        Thu, 16 Jul 2020 07:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14E9FC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [RESEND 1/2] ath11k: add WMI calls to manually add/del/pause/resume
References: <20200624080321.2271943-1-john@phrozen.org>
Date:   Thu, 16 Jul 2020 10:50:41 +0300
In-Reply-To: <20200624080321.2271943-1-john@phrozen.org> (John Crispin's
        message of "Wed, 24 Jun 2020 10:03:20 +0200")
Message-ID: <87pn8vx5im.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

John Crispin <john@phrozen.org> writes:

> These calls are used for debugging and will be required for WFA
> certification tests.
>
> Signed-off-by: John Crispin <john@phrozen.org>

[...]

> +static void ath11k_wmi_twt_add_dialog_event(struct ath11k_base *ab, struct sk_buff *skb)
> +{
> +	static const char * const status[] = {
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
> +		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
> +		return;
> +	}
> +
> +	ev = tb[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT];
> +	if (!ev) {
> +		ath11k_warn(ab, "failed to fetch twt add dialog ev");
> +		goto exit;
> +	}
> +
> +	ath11k_info(ab, "TWT Add Dialog Event - Status: %s, DialogId: %d, VdevId: %d\n",
> +		    status[ev->status], ev->vdev_id, ev->dialog_id);

Shouldn't this be a debug message? The info level should be used very
sparingly.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
