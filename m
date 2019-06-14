Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5045201
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 04:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfFNCwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 22:52:13 -0400
Received: from a1i1011.smtp2go.com ([43.228.187.243]:47223 "EHLO
        a1i1011.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfFNCwN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 22:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=mb6cr0.a1-4.dyn; x=1560481632; h=Feedback-ID:
        X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
        List-Unsubscribe; bh=kKigLPys3Ytf2UgAKduP8wpKh6EQxl2Aoj2gmWgEv+o=; b=2P60reGY
        bVDbYNkdi1IpLpnRa9GvkBga3nVGss2UqfgAcRt0ab6ThC5Wxf5XW2GTL+HUSgtUqdFIw8F8NtVwB
        b5iwZjud3UbYlPJGhQv7qAHIb2Md/3ZcU5MVSYIHu/V61g37aBD/lpHpdRMQuY99/z7EoqVKQ/7aw
        2Be/ouO0Cdaev9osiUioVzNxQ5IurS5zMfA9Em5BLkJLnxbxdtA/uYhhNr7a0llnsZUMeY4CnCiYM
        HRWeChFVFpzI96ka9czSYPtGLHemF0l0HI3AE4kbsLF5bUbCHpcP7zVYwuEulI5xraEGt63Rc+juA
        MYZFUT+Oo97QyQBDO3pHRUkUjg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=balki.me; i=@balki.me; 
 q=dns/txt; s=s521451; t=1560480732; h=from : subject : to : message-id 
 : date; bh=kKigLPys3Ytf2UgAKduP8wpKh6EQxl2Aoj2gmWgEv+o=; 
 b=IPVmokw+bfipWuD74xHhhbZSKrZ4rhXzf4lQAvCE0rAdybrOIZ1rsEWHV/uULNZF9mx2yR
 L8w1rde+OHfdOx7jtVI7B9gwBaC+gJjZEAPpe9RBcFBkGv/yQdlFPvPR049aENmxs6yAz4b6
 Jr6yaK1zhV23T2lFYXKltv/WB3Q4M6/974uNPTnWQhB+/+7m+RHIfHq7JU+RHW6WFPK8pBVj
 nj9EBs+HkM8ESNocQPz0TrIPfoFUHCmEwvHbYwiZVszLuG7CV4PT9vlfu6JEKG4pwFV9OOZK
 8YrrsjTJBkfmkbzNFiUdyS16iVzCxbHe743GcqhnzhMrG+JWC5Ib2HkQ==
Received: from [10.45.33.53] (helo=SmtpCorp)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <linux-wireless-list@balki.me>)
 id 1hbcJy-4pkSPj-NU; Fri, 14 Jun 2019 02:52:06 +0000
Received: from [10.135.23.123] (helo=zadesk.localnet)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <linux-wireless-list@balki.me>)
 id 1hbcJx-rlZAOV-R8; Fri, 14 Jun 2019 02:52:05 +0000
From:   Balakrishnan Balasubramanian <linux-wireless-list@balki.me>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Balakrishnan Balasubramanian <linux-wireless-list@balki.me>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi module crash
Date:   Thu, 13 Jun 2019 21:47:54 -0400
Message-ID: <2021645.iB4347jUHV@zadesk>
In-Reply-To: <CANUX_P3jUBREM=cwLHs8LE+ZbUVKGZNsBWGGepbS-mcHq0w9ow@mail.gmail.com>
References: <2455026.F8Aexx8IWb@zadesk> <2696773.yqXG4m880n@zadesk>
 <CANUX_P3jUBREM=cwLHs8LE+ZbUVKGZNsBWGGepbS-mcHq0w9ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart5498953.IlzcIGSqiQ"
Content-Transfer-Encoding: 7Bit
X-Smtpcorp-Track: 1hPcJxr_ZjOVR8.j8vWxLoLk
Feedback-ID: 521451m:521451aMgsuo0:521451sZ9B4uoj52
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart5498953.IlzcIGSqiQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

The issue occured again today. I tried to restart the module

> echo 1 > /sys/module/iwlwifi/devices/0000\:02\:00.0/remove

There is no folder 'devices'

zadesk% ls /sys/module/iwlwifi 
coresize  drivers  holders  initsize  initstate  notes  parameters  refcnt  
sections  srcversion  taint  uevent

> echo 1 > /sys/bus/pci/rescan

Attached the error when trying to rescan.

Thanks,
Bala





--nextPart5498953.IlzcIGSqiQ
Content-Disposition: inline; filename="error"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="error"

Jun 13 21:41:56 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for hcmd
Jun 13 21:41:56 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFFLOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 13 21:41:56 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 13 21:41:56 zadesk iwd[483]: Received error during CMD_TRIGGER_SCAN: Input/output error (5)

--nextPart5498953.IlzcIGSqiQ--



