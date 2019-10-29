Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7BE88FD
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 14:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbfJ2NCQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 09:02:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39235 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NCQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 09:02:16 -0400
Received: from mail-yw1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPR8Y-0008Jh-6Q
        for linux-wireless@vger.kernel.org; Tue, 29 Oct 2019 13:02:14 +0000
Received: by mail-yw1-f70.google.com with SMTP id g69so7766246ywb.2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 06:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cp53bQudZb0boC1RUY5xnKwbssOLo/XyTV2GZ3CQn58=;
        b=Jwc8vJTPDb7JKyH27rByUnPwUFbLkaEI8GICQ5sJ3ijLVremvBGyxj6aGXXQ/zLL4B
         OjK/0dnZk44ElroaDIrAn111bZbWjNtJJMhzWJNOLhnay98xI8EurYzbSJNwh4pTvTrH
         Du8WVDIoaloll9yiVuzqVMKskis+fRmJtQd6vIixGyeAxR6jpbBp5NUaU3IYMwEMD22m
         llZptbCijikU9ZsQt3gYW92eLXp3IgvsTOlwP7VRN6ADRbXfy408moOzUD1Kc3/UiAyf
         UB4kYzaC1S9UZZuw16EENVW3gxFMWNahYSgS6i7wVsfJ8RsmBwcrXxNgBG03p/3AzCZf
         5Tww==
X-Gm-Message-State: APjAAAXukPp1XpCv8zHFkEjXWkvzqbe1trpclsabSvWsg0SMPCHesXuz
        GAgZdlyiClUHookXY0vsVRZk2+IGQxU3H1gYjK/6wfvA2mhtLt7Y7fKfgvJcoET5JsA4PrhxoV7
        qBSEUAntIlmIRxoIKVfHQnzArTBHouHHNUTBTnZ/5yFNv
X-Received: by 2002:a81:a9c1:: with SMTP id g184mr17359117ywh.320.1572354133248;
        Tue, 29 Oct 2019 06:02:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+7UNt4X0/6LsxXHcPawxFuTOQB+G0MQJkBIrtdaZGtQm9ckIzJ2sMNYwCCo9kBeKHS7hdlw==
X-Received: by 2002:a81:a9c1:: with SMTP id g184mr17359013ywh.320.1572354132346;
        Tue, 29 Oct 2019 06:02:12 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id q124sm19663556ywq.8.2019.10.29.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:02:11 -0700 (PDT)
Date:   Tue, 29 Oct 2019 08:02:10 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Emil Petersky <emil.petersky@streamunlimited.com>
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Subject: Re: [PATCH] wireless-regdb: Harmonize ranges of CEPT countries
 (stand of July 2019)
Message-ID: <20191029130210.GM30813@ubuntu-xps13>
References: <bf327181-521b-e1ce-c5c8-81b828fc65b6@streamunlimited.com>
 <20190907235636.GA8256@ubuntu-xps13>
 <a5bdfce7-e974-37bb-c1d1-956d4572703c@streamunlimited.com>
 <39933518-6a65-fab3-4a66-8f44fc319d57@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39933518-6a65-fab3-4a66-8f44fc319d57@streamunlimited.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 17, 2019 at 10:59:08AM +0200, Emil Petersky wrote:
> This patch unites entries for CEPT countries according
> https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
> (CEPT ERC Recommendation70-03, Edition of June 2019) which lists all
> CEPT countries, who has harmonized those standards.
> 
> The most important (definition) entries are:
>   Table 1 / rows i and j (SRDs for 2.4 and 5GHz bands)
>   Table 3 / row b (2.4 GHz band)
>   Table 14 / rows e1, e2 and f (5GHz bands)
> 
> and Appendix 1 - National implementation
> with sub-tables and rows representing implementation of above standards:
>   ANNEX 1: NON-SPECIFIC SHORT RANGE DEVICES
>     Annex i: 2400-2483.5 MHz
>     Annex j: 5725-5875 MHz
>   ANNEX 3: WIDEBAND DATA TRANSMISSION SYSTEMS
>     Annex b: 2400-2483.5 MHz
>   ANNEX A: INFORMATIVE ANNEX COVERING THE APPLICATIONS OPERATING UNDER
> GENERAL AUTHORISATION...
>     Annex e1: 5150-5350 MHz    ECC/DEC/(04)08
>     Annex e2: 5470-5725 MHz    ECC/DEC/(04)08
>     Annex f: 5875-5905 MHz    ECC/DEC/(08)01

Applied, thanks!
