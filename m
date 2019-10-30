Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC95E9652
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 07:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfJ3GQw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 02:16:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfJ3GQw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 02:16:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB19D60F5E; Wed, 30 Oct 2019 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572416211;
        bh=IgyGKLGNT89B33oQraHU/asdxUwmWTKhlEwPQxbrLt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QnPtQgN2gnebrVx0mLoDiLQmIQQU0N5NCKI03K/ZeacRgzFq0JiFJ5OdWaVgJLbvJ
         dB66tLxsOmtczO9i1LSX0B3zyAB+JEB+I4mOY2L6m1tg8/wUZrBaTMvwItbfcWZ8QR
         UOO/SmxvrlmNAKGMC0o4stCtXMOE1yleBiTcNzVU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A6A9260A97;
        Wed, 30 Oct 2019 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572416211;
        bh=IgyGKLGNT89B33oQraHU/asdxUwmWTKhlEwPQxbrLt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QnPtQgN2gnebrVx0mLoDiLQmIQQU0N5NCKI03K/ZeacRgzFq0JiFJ5OdWaVgJLbvJ
         dB66tLxsOmtczO9i1LSX0B3zyAB+JEB+I4mOY2L6m1tg8/wUZrBaTMvwItbfcWZ8QR
         UOO/SmxvrlmNAKGMC0o4stCtXMOE1yleBiTcNzVU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Oct 2019 14:16:51 +0800
From:   zhichen@codeaurora.org
To:     Peter Oh <peter.oh@eero.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
In-Reply-To: <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
 <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
Message-ID: <8c6d531f6474faf4df55f90185466774@codeaurora.org>
X-Sender: zhichen@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-23 01:16, Peter Oh wrote:
> 
> How can you say value 0 (I believe it's 64 bytes) DMA burst size
> causes the symptom and 1 fixes it?
> 
> Peter

Confirmed from HW team that the configuration controls AXI burst size of 
the RD/WR access to the HOST MEM.
0-	No split , RAW read/write transfer size from MAC is put out on bus as 
burst length.
1-	Split at 256 byte boundary
2,3- Reserved

That's why we see issue with value 0.

Zhi
