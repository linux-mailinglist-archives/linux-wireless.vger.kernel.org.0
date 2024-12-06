Return-Path: <linux-wireless+bounces-15958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F19E6805
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 08:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E5281C67
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959F32C8B;
	Fri,  6 Dec 2024 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XjRE00tC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96F1DB37A
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470604; cv=none; b=FIr2zx32r0NXIlHdgm//e/qEI15Z6CKhTa48C5HYlmvhJQxjQisD8OQNTYDY7QdBx+anRlseJW+dOqfE+z4M6/q9yY86f9A3Xf2oig5ICQuotsiB14ahvpPHRHN6dB16c01ICsbyn2yCa1P52JSxStfcE0TIxaxHRUVS4P5Okhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470604; c=relaxed/simple;
	bh=R2b8JPFNZvtT/qnecpDd8JlyC1t9QuWbx638Oxi9YIw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Jhnzz99wQ2U4siBVQEu1P6+W7E4iGe8jGzgVps0jd9kUJIZ97F8zSn1PRC9nebc5sDUkH6rLDnZuYSfbLWUlRM8J9S/FWTeolwzobIngEbrnKqu1Yn0kDibgMZjqpK09BOHzaYVLoezU/IpGLJJW2UEGgSbwHg3QKTlMinqwkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XjRE00tC; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afae40c8bcso519917137.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 23:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733470601; x=1734075401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvTef5XrjTteTCmC/XIUI4aDXbisTR8qCV0PsXvWYbk=;
        b=XjRE00tCtKCr7VogVxgiahq8wRDL+PCrbZUasvuIM8W44iUI9YClRgegHG6bWs91wd
         yrq0hcuRmzSDK/PWkJqVjJ8DdUoldiG5cAv3vCjuEopaI7iFoRLkd3nAnusTHum+4Yaf
         6QgSAneQgNeX7g/diKqpUWuPPKsr+pdhppSE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733470601; x=1734075401;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvTef5XrjTteTCmC/XIUI4aDXbisTR8qCV0PsXvWYbk=;
        b=COYlVN0ZkNF+I8Gz15jaqusODpAf5tPbCPxiDG/qsYuvB/7blYwK3elGfAgZ2fUCkW
         Z9Y4Cs1RwXTWwBQ9/9Gsq3gM5B0mET/Cyby6OC4lbg+4Fk3XoolNqemvQ9WUPBhO0haP
         PpReojo0b3mYTa/cwOizsYETF3s0kgCVg8/4Ma9wb93soy8wqDWernUFIu1vc1Gw6Gdb
         saYfTrW5k0Hz9lLOFD7GLfXkIkHvBc4g4Qmolm7xjN8rZV83DC8zqtwgoKoHU2Ue5UkX
         CkAfZAEnLKovfET6uozEg9g9qgqv6Q3/KtzP4LKYp1Qh2/jLa2l845nw22BdA+lvIgcC
         ptHA==
X-Gm-Message-State: AOJu0YyctI/xn3atJSSSlTkbF6f7EM9Z5pCbJQx/PmWJ4cxPx/+ynJij
	Rr4cLi1GALu6uT7zmMBKZ6rO8fgUNj+3sTiXwZd/xy2Ahcci6+tj0dB4L+WrTA==
X-Gm-Gg: ASbGncvaNdke8S85f+qdqhZ2WaA1hEKx23juqGLA7+kdr2cRhwjVaxa3to3KAuEs0rX
	WHOIJwc7Vf8aB8rWwczNSQt+E9VX3v+CLwkAP+5hX/Ff2aqx2H/26A2Fy11ptI78PcBM3ltFrda
	7WIVG0yaSpYf8AhBncGsvLQGaHAphve2ti3xa30zI1ORArPeANX6NE8a9WpFDhAeZw98igsG+FP
	R56tshV5Hdzja3JAfZats8rNtUOaYOSkIyHAFbsJuZ+xKDN5sHPvS3qVFjC3B6GA5ySjjeACvpk
	Xf8qdTn2Xxrn
X-Google-Smtp-Source: AGHT+IEdrJA5kZdzSk/bqOIxvCD9St6CvmkAFVvX0NSNo11j2E2dNBNdxQ9JgiXGwkZU3crEsGs8mw==
X-Received: by 2002:a05:6102:e0c:b0:4ad:4895:ce1f with SMTP id ada2fe7eead31-4afcaaecf4bmr2669897137.17.1733470601037;
        Thu, 05 Dec 2024 23:36:41 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467297c2356sm17955551cf.80.2024.12.05.23.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 23:36:39 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
CC: <linux-wireless@vger.kernel.org>, <ys3al35l@gmail.com>
Date: Fri, 06 Dec 2024 08:36:34 +0100
Message-ID: <1939ae623d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20241206065324.91702-1-renjaya.zenta@formulatrix.com>
References: <6b2fcdb4-f00d-4a17-909d-f92ed0240cbf@broadcom.com>
 <20241206065324.91702-1-renjaya.zenta@formulatrix.com>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On December 6, 2024 7:53:28 AM Renjaya Raga Zenta 
<renjaya.zenta@formulatrix.com> wrote:

> On Thu, 5 Dec 2024 14:10:51 +0100 Arend Van Spriel wrote:
>> Can you try the patch attached?
>
> I've just tried this in 6.6, obviously the errors disappear. Tested with
> DUMP_OBSS enabled.

Thanks, Renjaya

It was the pragmatic fix. There still seems a potential issue in how 
brcmfmac provides the channels to cfg80211.

> Will this also land to stable?

I have not formally submitted it to linux-wireless. I will add the 
appropriate tags for stable.

Regards,
Arend




