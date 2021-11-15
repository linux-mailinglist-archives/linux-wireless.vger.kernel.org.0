Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E3445028E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 11:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhKOKdq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 05:33:46 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:55868 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhKOKdO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 05:33:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636972217; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=/kuNOKqnJebygxjyZF24saC37qgfQpUlPF991iaAtQg=; b=olD3uLFwnkbMTraHHL8xSWEhKq9ilsrAFZO0+qlfpnh2oyQLbzqRgGcBV0YPz3BE+kh7IkC7
 tkql92M45G4mFQE57gv5Dq4h5kl3L/9sZ0RX4lEryGMLp4QybD8ailQbpb5T4FRgyVdgiqbW
 OFdtmXnYbLKca5ie7uPzYUA7VWA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 619236b8a9c3e8b85b5eec69 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Nov 2021 10:30:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69116C43460; Mon, 15 Nov 2021 10:30:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29271C4338F;
        Mon, 15 Nov 2021 10:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 29271C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/7] ath11k: support one MSI vector
References: <20211026041616.4956-1-bqiang@codeaurora.org>
Date:   Mon, 15 Nov 2021 12:30:10 +0200
In-Reply-To: <20211026041616.4956-1-bqiang@codeaurora.org> (Baochen Qiang's
        message of "Tue, 26 Oct 2021 12:16:16 +0800")
Message-ID: <878rxpiudp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> writes:

> This patch set is to support one MSI vector for QCA6390.
>
> Depends-On:
>   1. ath11k: Fix crash caused by uninitialized TX ring
>   https://patchwork.kernel.org/project/linux-wireless/patch/20211026011605.58615-1-quic_bqiang@quicinc.com/
>
> Baochen Qiang (1):
>   ath11k: Set IRQ affinity to CPU0 in case of one MSI vector
>
> Carl Huang (6):
>   ath11k: get msi_data again after request_irq is called
>   ath11k: add CE and ext IRQ flag to indicate irq_handler
>   ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for DP IRQ
>   ath11k: refactor multiple MSI vector implementation
>   ath11k: supports one MSI vector
>   ath11k: do not restore ASPM in case of single MSI vector

I assume this is v2 of Carl's patchset:

https://patchwork.kernel.org/project/linux-wireless/cover/20201223030225.2345-1-cjhuang@codeaurora.org/

Can you provide a changelog? No need to resend because of that, just a
reply to this thread enough.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
