Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6B910D216
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 08:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfK2Hvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 02:51:32 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:44494
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2Hvc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 02:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575013891;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=zbDRZKnzjriupggRUWMUcPV4MUfQd9en53bon+5ItNY=;
        b=mzSEyiwO8tfCa089rpaMkJJi8Il3IQdsRve+IyOll2v+KGI1uFY05jHUwf8P09EB
        ZCVcl+dm10WefxhKlPFvlrct7229c5F6fUKyiDijq5MPVNXwxlKnf/Fj4jKS/peVj+o
        crdu+NVX9AdmW5igK2Yr9AzboAtpNW2ewyYmvqbk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575013891;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=zbDRZKnzjriupggRUWMUcPV4MUfQd9en53bon+5ItNY=;
        b=XCkC1jQx5Vyb29xjRcYfr4osEVowoFXSlKm8Jhv6Ysqp7E0pKZx0tYz8sIeYZk9m
        dtF8IrYmnL+R/C/28vCU4BnVXNiIKLdGPoC/D5hV7NdVon9gjvPcWIuJkuTGFWHX08q
        KSbRteQxlbZy5Y7WOGrOLaAZNabCrrm4xKTsKGws=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FA93C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] ath11k: Update tx and rx chain count properly on
 drv_set_antenna
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016eb11a10c9-dd904af5-539a-4c05-9ffc-3a1cc33b99f5-000000@us-west-2.amazonses.com>
References: <0101016eb11a10c9-dd904af5-539a-4c05-9ffc-3a1cc33b99f5-000000@us-west-2.amazonses.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eb624be5e-239bf88d-ea4f-4d02-9c19-da771b861778-000000@us-west-2.amazonses.com>
Date:   Fri, 29 Nov 2019 07:51:31 +0000
X-SES-Outgoing: 2019.11.29-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Set the number of tx and rx chains properly on drv_set_antenna().
> This will ensure the related ht/vht/he caps are properly recalculated
> based on the tx/rx chains set.
> 
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

9 patches applied to ath-next branch of ath.git, thanks.

a3c5195a97af ath11k: Update tx and rx chain count properly on drv_set_antenna
c000e56ee6b0 ath11k: Advertise MPDU start spacing as no restriction
5e02bc7354e1 ath11k: fix memory leak in monitor mode
28dee8ef7645 ath11k: fix vht guard interval mapping
a9e945eadf17 ath11k: update tx duration in station info
b9269a078ae6 ath11k: Skip update peer stats for management packets
0366f42640a4 ath11k: Move mac80211 hw allocation before wmi_init command
9c57d7e3b488 ath11k: Setup REO destination ring before sending wmi_init command
fcaf49d0f2dc ath11k: fix indentation in ath11k_mac_prepare_he_mode()

-- 
https://patchwork.kernel.org/patch/11265469/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

