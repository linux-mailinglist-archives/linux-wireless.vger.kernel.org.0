Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7900149CF4
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 22:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgAZVME (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 16:12:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42548 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAZVME (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 16:12:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so8552784wro.9
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2020 13:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=WAHPhjncLqhI8arfSYYGqzR8Ij3uFjcEoo0Veaj+1Ys=;
        b=CkcXexuxy0qhvjUJX75L4ba0otYVO34CVzb0DKCCQ034Pcpyc2+8wmGPR+OXNzZR+0
         LoEwGfJ0Lc3ydmbUs3GbrwNWf+6RcwNcuNDu0QArP+F3VU6VbGvgDQD38lJ2ksaB4VYn
         S1zfF0op5dQonf17V1miBwbjLq+e7X2L5yeIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=WAHPhjncLqhI8arfSYYGqzR8Ij3uFjcEoo0Veaj+1Ys=;
        b=ClJUb4ohtxgITxUXjg8mlFXWpKyc2qcRpMIGRIaI5YOzSX9m/hxS9lfV51yQA+lTot
         OhnKS6CkZiZHUHuMP3yhmk0dQsqs4nHDPSZUTW9oo4GwiTJDHK7rOjBge/492zart454
         BASaYKoT9RFik4YbEvETnaCPn6lvI6hDIV2xDGs1NwnReMC9P1KpL7UZviI2IOFGqnSU
         ehiCp23Em6aYzO0vj+A0pKwi+4b0/PXY2GjQ9uSg63iDllvhC26zTyoMCkiYY9CBWCVB
         gK/GaTcyvbJzJfrHTiEO1pkVY7gfoSW18/abws7GfVeI+UTzkeis2nzK1aoMHzLuRxPV
         GKsg==
X-Gm-Message-State: APjAAAWa9jbutgyOv9OCv5GWW8CMKBxblwl1plXOEJXHUomnV6uJYSWW
        OdzmY0wIIiNFdUpV9Qd+HwwQNg==
X-Google-Smtp-Source: APXvYqyGbunozuK/LtyfMkeVCl7JA2p9+80Suc7S49tXZ92Xa7xJg00DSNlZbuwhHlMoczkJinF+nQ==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr18629473wrh.371.1580073122719;
        Sun, 26 Jan 2020 13:12:02 -0800 (PST)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id q10sm6847382wme.16.2020.01.26.13.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jan 2020 13:12:01 -0800 (PST)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <brcm80211-dev-list@cypress.com>
CC:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "Chi-Hsien Lin" <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Date:   Sun, 26 Jan 2020 22:12:02 +0100
Message-ID: <16fe3b278d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20200126193339.167346-1-sandals@crustytoothpaste.net>
References: <20200126155108.7DDD7C433CB@smtp.codeaurora.org>
 <20200126193339.167346-1-sandals@crustytoothpaste.net>
User-Agent: AquaMail/1.22.0-1511 (build: 102200004)
Subject: Re: [PATCH v2] brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On January 26, 2020 8:34:18 PM "brian m. carlson" 
<sandals@crustytoothpaste.net> wrote:

> The 2018 13" MacBook Pro (MacBookPro15,2) has a Broadcom chip, the 4364.
> This chip appears to be specific to Apple and is not found in other
> hardware.
>
> Add this chip to the brcmfmac driver so that it can be recognized
> automatically.  Note that the PCI device id is 4464 even though the chip
> is referred to as the 4364.

So what is the plan regarding firmware. In the previous patch you mentioned 
it can be copied from macos, but I am not sure if that is acceptable from 
legal perspective. At least Linux distributions will have problem with that 
for sure.

Regards,
Arend


