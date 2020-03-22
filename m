Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546C218E963
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2020 15:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCVOcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Mar 2020 10:32:09 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:10981 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgCVOcI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Mar 2020 10:32:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584887528; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=VVcprMyziU1PpTArhyS/R+JtLT3/GZ1KW7ru8szL11Q=; b=mn5IRWIlioOVPdbibXIXVVHOzEHY8aLAD5VU4TKwGzgH/8f0Au0VLpG1WzLsvk/oJdMOIQgg
 OaSulO3i0QCGZOW7WY9JcwjHL28u/xXKxDYgGNieTTyrn1UqnmLsYvLGI4cXbRb3QET4aySG
 ENTY2+wWQgWEdSyVEUUL09i9/yQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7776e6.7feec565c880-smtp-out-n02;
 Sun, 22 Mar 2020 14:32:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDA2DC433BA; Sun, 22 Mar 2020 14:32:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 940D4C433CB;
        Sun, 22 Mar 2020 14:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 940D4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a module parameter
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
        <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
Date:   Sun, 22 Mar 2020 16:32:02 +0200
In-Reply-To: <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
        (Wright Feng's message of "Thu, 19 Mar 2020 02:53:26 -0500")
Message-ID: <87tv2gbgv1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> writes:

> With setting sdio_wq_highpri=1 in module parameters, tasks submitted to
> SDIO workqueue will put at the head of the queue and run immediately.
> This parameter is for getting higher TX/RX throughput with SDIO bus.

Why would someone want to disable this? Like in patch 2, please avoid
adding new module parameters as much as possible.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
