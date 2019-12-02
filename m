Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7910EBCA
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 15:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBOtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 09:49:31 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:59682
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfLBOtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 09:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575298170;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=fc0TCpGmJNbhU79nDoexOq2pO8hL6gJXkSf6lpYIZYY=;
        b=LbOKHzZ2ap1jN65A57VFtyw83/xSh31I6ghHJZzyhzHCX007Jq0Sjw1QOF7yME1X
        M6a5KCyChu51X9KlcCNljoJtrxsEYJxMSCmG4NJCJVz1AmG+yOEVM+9T3tyPbGzfWNS
        Vc6Md52Kn13A1NLANw6CmaIkfOvID37nea/dXrQE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575298170;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=fc0TCpGmJNbhU79nDoexOq2pO8hL6gJXkSf6lpYIZYY=;
        b=ThfONfbmJTNsuRW7EjZzst+P+LPQ1143aRPSeeNTqui2Blne7QGrw1Xwn5dJBKtJ
        uop5/VMl48osdfcOA8IABPgJPjIzJqBINtjzHi60MLO9bGuxmsEyIfmTP8adIcDcz9g
        dnabHMOnG3oVEJCbsU2HhlFCBOG6pqvYzvIlVH1c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9367C447A6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt76: mt76x0: fix default mac address overwrite
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <567a7cda15f641acb6eab5970370c9bfac96793e.1574548832.git.lorenzo@kernel.org>
References: <567a7cda15f641acb6eab5970370c9bfac96793e.1574548832.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, kevin.patrick.schmidt@googlemail.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ec7167e24-e30dd2ba-c8a3-4b8d-a248-29e739e9dfdc-000000@us-west-2.amazonses.com>
Date:   Mon, 2 Dec 2019 14:49:30 +0000
X-SES-Outgoing: 2019.12.02-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Current implementation always use default eeprom mac address to
> configure device registers even if it is updated using
> mt76_eeprom_override. Fix it initializing macaddr filed of mt76_dev data
> structure with eeprom mac address and running mt76_eeprom_override
> before mt76x02_mac_setaddr
> 
> Fixes: d1bc9bf2072c ("mt76: mt76x0: eeprom: add support for MAC address from OF")
> Tested-by: Kevin Schmidt <kevin.patrick.schmidt@googlemail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

693d060536ab mt76: mt76x0: fix default mac address overwrite

-- 
https://patchwork.kernel.org/patch/11259011/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

