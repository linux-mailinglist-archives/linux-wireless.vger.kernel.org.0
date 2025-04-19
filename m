Return-Path: <linux-wireless+bounces-21749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B99A941ED
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 08:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC588A2C8E
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 06:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA9B1714B7;
	Sat, 19 Apr 2025 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V4K2lFc2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470715B135
	for <linux-wireless@vger.kernel.org>; Sat, 19 Apr 2025 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745043137; cv=none; b=CGiLVnhmAlHhnyMD1ALz6MKJtq+wLRkQmEtfJnfm3brrPIVtkQHqxTUNOYu8Tkw6Ek2ycObd19GzTe962vbxct+rUQbuLwlwMg9g6bf3WUuzWYWDeziKCqVSVimO/B9KloggU1DmIi3w+CbuoY8XW9x9vYSBTPmKCoV9PQXB9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745043137; c=relaxed/simple;
	bh=Ie6E9+Cz2M+b1Ax+NWAC867vl1DZ80jK1rYLi/Pjqy4=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CNCZTqPKPCe8eSYjp38VjmSOHjN6fKp9+hFE7zfsupMx/+KLxp2nzvNAo7/k8aY+hq052hgCI5ENJgCSj2toTOAixpD9Eize3+KSPmDHYuIVcZ6qSsT0w0j9lT+Gfwm+BCxox+kut/8xE2kScvmX3YwnfxmR91/Pr2kqOHa919g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V4K2lFc2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c173211feso680938a34.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745043135; x=1745647935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP8/dJNp46UHV62QUh3SEkJZyuswHt+JJ4RJenOYVm0=;
        b=V4K2lFc2bdRgR6UdANq0I6udyOjImw8ewirp0FCUfLgGlvcJhBE7legjq/fFd2Qu2s
         Q/ro48e809YrhLw1i9YpPutGgz7PyK+1+009rrnJuPdugUiegL/lDoXnqtfYFHlejZjo
         HTk1ik3YCIdnOIivrzLHPxs6iZLGAlOLGFDaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745043135; x=1745647935;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tP8/dJNp46UHV62QUh3SEkJZyuswHt+JJ4RJenOYVm0=;
        b=sm3nntUTOeAfSv1dDBs6nF5tsmFX4eRRlHrUn9wrQBBRslXbTRotOHWDrILxr73r/2
         AtMz6MwZw/0jYe2pcKyr0/0k/A2jQcR9QbEEWFFSrxVOv4FcXWvPX4IhXGeplkzX5nmu
         T2+iDEooifkdIOXoybZoigSKAzIbh8nfrQmj40yqx2+9lhWAK3EFaR3djmFIVcBpS81T
         v/IDAa7at3bTtMdCxaAvSNAUjh4TGEWRtkFl5izE4vHqiralfgFuFN0FgjiS6/q+x13x
         qvWpNbrA1NYFNfxV1v7xhqBOYlqEQgzN6CEz95lu505QE4yrY+Epf5CSOlR0ujZ1RzXA
         T8bw==
X-Gm-Message-State: AOJu0Yw3bFHD0VoFSpuXZ9hqpEv640pDrgp4mAH1BtZktBVB4iVgMfli
	aVcGdbEMytNqLD6uaoCh67VU3LK7LzmgGVYxZaB4CzLup8X/Ro5ngnf6sJHFvw==
X-Gm-Gg: ASbGncseLCVGAe+G2TjWJFqGnrqWzvGwKO7DyjckP97qzhFKNrFhv38QQYX8ntRN41s
	SVI2xNZzdKmjMlkitxC7mlOVE0xLvjk0yKSXPtClnsph4a1qmZSTvElbE19xNL/22FaayG05YmB
	+Can/pPviHQlRjQc+UNKAbSQ5ytDAh1ivAyu19UD9Um2/hO24borRyz+LUoC3WzKSCs++aGXIlS
	GTasyxi299vOUpvl/nM91H2nFRZWCPV/VBQLziLNVOE+0j2rjvdsFW3jUzhgfKGYMpPvrAtp7IB
	9TDF+i8rI8WlY8OQfLhNgYOdQp4C+RkTzBFhW9qLM4qQ9PAebQTht0l94YdvRYAQPjiobYZtUy6
	WSh8=
X-Google-Smtp-Source: AGHT+IHM0SenNE2iDmrijOLGfZvyVD0hWZPVHvME0njnaGJlIozaoBEhmdJf3T2sHocDTPlwrv0+Jg==
X-Received: by 2002:a05:6830:610e:b0:727:345d:3b83 with SMTP id 46e09a7af769-730063540f1mr2896667a34.23.1745043135104;
        Fri, 18 Apr 2025 23:12:15 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730047ca051sm607918a34.36.2025.04.18.23.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:12:13 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <wlan-kernel-dev-list@infineon.com>
Date: Sat, 19 Apr 2025 08:12:10 +0200
Message-ID: <1964cad0690.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1964ca7ede0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <20250416060128.15703-1-gokulkumar.sivakumar@infineon.com>
 <1964ca7ede0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH] brcmfmac: fix compilation error seen while building only brcmfmac sub-directory
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On April 19, 2025 8:06:40 AM Arend Van Spriel 
<arend.vanspriel@broadcom.com> wrote:

> On April 16, 2025 8:01:58 AM Gokul Sivakumar
> <gokulkumar.sivakumar@infineon.com> wrote:
>
>> The function prototypes of brcmf_debug_create_memdump(),
>> brcmf_debugfs_get_devdir()
>> and brcmf_debugfs_add_entry() are protected by the "DEBUG" config MACRO in
>> debug.h,
>> while the corresponding function definitions remains unprotected in
>> debug.c, so add
>> the missing MACRO definition check.
>>
>> Compilation error seen while building brcmfmac sub-directory with
>> CONFIG_BRCMDBG=y
>> is captured below.
>>
>> $ make M=drivers/net/wireless/broadcom/brcm80211/brcmfmac
>>
>> make[1]: Entering directory
>> '/root/wireless-next/drivers/net/wireless/broadcom/brcm80211/brcmfmac'
>> CC [M]  debug.o
>> debug.c:17:5: error: redefinition of ‘brcmf_debug_create_memdump’
>> 17 | int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
>> |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from bus.h:12,
>> from debug.c:13:
>> debug.h:136:5: note: previous definition of ‘brcmf_debug_create_memdump’
>> with type
>> ‘int(struct brcmf_bus *, const void *, size_t)’ {aka ‘int(struct brcmf_bus
>> *, const void *, long unsigned int)’}
>> 136 | int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
>> |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> debug.c:45:16: error: redefinition of ‘brcmf_debugfs_get_devdir’
>> 45 | struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
>> |                ^~~~~~~~~~~~~~~~~~~~~~~~
>> debug.h:127:30: note: previous definition of ‘brcmf_debugfs_get_devdir’
>> with type
>> ‘struct dentry *(struct brcmf_pub *)’
>> 127 | static inline struct dentry *brcmf_debugfs_get_devdir(struct
>> brcmf_pub *drvr)
>> |                              ^~~~~~~~~~~~~~~~~~~~~~~~
>> debug.c:50:6: error: redefinition of ‘brcmf_debugfs_add_entry’
>> 50 | void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
>> |      ^~~~~~~~~~~~~~~~~~~~~~~
>> debug.h:132:6: note: previous definition of ‘brcmf_debugfs_add_entry’ with type
>> ‘void(struct brcmf_pub *, const char *, int (*)(struct seq_file *, void *))’
>> 132 | void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
>> |      ^~~~~~~~~~~~~~~~~~~~~~~
>> make[3]: *** [/root/wireless-next/scripts/Makefile.build:203: debug.o] Error 1
>> make[2]: *** [/root/wireless/wireless-next/Makefile:2006: .] Error 2
>> make[1]: *** [/root/wireless/wireless-next/Makefile:248: __sub-make] Error 2
>> make[1]: Leaving directory
>> '/root/wireless-next/drivers/net/wireless/broadcom/brcm80211/brcmfmac'
>> make: *** [Makefile:248: __sub-make] Error 2
>
> To be honest I am not sure whether to accept this patch or not. The way the
> makefiles are setup was never intended to support this usage. The cause of
> the failure lies within the fact that the makefile in
> drivers/net/wireless/broadcom/brcm80211 passes -DDEBUG to the subdirs:

# common flags
subdir-ccflags-$(CONFIG_BRCMDBG) += -DDEBUG

> Also
> I recall using the M=<dir> option result in out-of-tree taint. That said
> the following does work:
>
> $ make M=drivers/net/wireless/broadcom/brcm80211 modules
>
> So I tend to discard this patch.
>
> Regards,
> Arend
>
>> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
>> ---
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
>> index eecf8a38d94a..3cb50140eb2f 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
>> @@ -14,6 +14,7 @@
>> #include "fweh.h"
>> #include "debug.h"
>>
>> +#ifdef DEBUG
>> int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
>> size_t len)
>> {
>> @@ -54,3 +55,4 @@ void brcmf_debugfs_add_entry(struct brcmf_pub *drvr,
>> const char *fn,
>> debugfs_create_devm_seqfile(drvr->bus_if->dev, fn,
>> drvr->wiphy->debugfsdir, read_fn);
>> }
>> +#endif
>> --
>> 2.47.0




