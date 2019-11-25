Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F60108D49
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfKYLwv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 06:52:51 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:44988
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfKYLwv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 06:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574682770;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=uWtxVtS/eSocGqMTSWcaIGLD0hEon0BJRNZIcLgytwk=;
        b=ZbjQfGbfSCHqpd+2sjw1u1k7exhLF9+ZRTTWH8HYSgKFrulE8W11sbvNIuN6E+Wd
        k/xPD566mcMEXLmdTJvCdvsHVxGq2q9lAy7dJE1NST3B3mBdcOEfuV6OuOzhS+Puj5A
        2tcKUoH2MaL4lFeLwDc5D3UXzqZ3lf8s5RWhS51o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574682770;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=uWtxVtS/eSocGqMTSWcaIGLD0hEon0BJRNZIcLgytwk=;
        b=g09fEv2ZMECSkOVKP5YkbwGJP8IemNBMuMLBE00uAdTH/pAuuohp9P21rm1Mcwt0
        vD9fx3ifd8vP15XEHD/56wqBVTowG7/9uVVFOaiL2MVOBysUCIoeANX+Rqx8puzaEiA
        AWn0jtgUKUCL2THO6HmxZEYGX7/WcfX22LCKnQV8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12F9BC76F44
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: correct the tlv len of
 ath10k_wmi_tlv_op_gen_config_pno_start
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191107093031.24131-1-wgong@codeaurora.org>
References: <20191107093031.24131-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ea2683c76-cfe15bc7-275b-42b3-9154-e08e23333db1-000000@us-west-2.amazonses.com>
Date:   Mon, 25 Nov 2019 11:52:50 +0000
X-SES-Outgoing: 2019.11.25-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> the tlv len is set to the total len of the wmi cmd, it will trigger
> firmware crash, correct the tlv len.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1 and QCA6174
> PCIE with firmware WLAN.RM.4.4.1-00110-QCARMSWPZ-1.
> 
> Fixes: ce834e280f2f875 ("ath10k: support NET_DETECT WoWLAN feature")
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e01cc82c4d1e ath10k: correct the tlv len of ath10k_wmi_tlv_op_gen_config_pno_start

-- 
https://patchwork.kernel.org/patch/11232379/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

