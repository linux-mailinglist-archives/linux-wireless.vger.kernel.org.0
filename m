Return-Path: <linux-wireless+bounces-1308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8F81FB84
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 23:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267CE284636
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26451096A;
	Thu, 28 Dec 2023 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rHPA/BbR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FA10960
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-203fe0e3fefso3388458fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 14:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703802011; x=1704406811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fFugFLuJ8vMteV8DFgbuwMKXul3+UHBzBJUgvyDGXaI=;
        b=rHPA/BbRjf3adNEv/jkZy3NkQWeQTeSJs/JNobis/N2/sAiT66mnSRKIKJE0vY01jQ
         79B9mqAZK+SNQMhPMJN1x1a1oICFZikUwLGkn7QsHVMKdFxgxzpK2RZ/CHsga7iAt47N
         BitEk++pR2AHIByRcwHEfeIKGkBh0tuiwTRVkas6b+crwaV3UJnsjaP5TkcesVoEHH5u
         jhkeiuO6+i5R0m4pzVBi2VlqTDNidRQscanlMFz85LyfT8g/Sv9vk4d60J+E0kRJQQ4o
         4upWhaLRtaA9csgd95ZJVVAi13ktjCxLYQ8IYAQsaMTjkLO9B+yuK2kIQHEHTPmERh7k
         9mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703802011; x=1704406811;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFugFLuJ8vMteV8DFgbuwMKXul3+UHBzBJUgvyDGXaI=;
        b=Mb5NnqBxOxR/vyf+3mca1wVSFg8ySa5cAg12zeNUUoZnfgVmP3ERmOEA3suFJH060p
         QtfHKe0HhZYTqPAr9QT2fUYebGRYofk2BWnX53y+//zqJImhN7A979LL2JA1zRCq6+mv
         1fcBtrP+uXFS5tri5t1HBpihhXuvSAuVqvRoDKBFlOvMgvOzySxrglxVrkCm84l9N/xV
         sr72H8dRH8njR7udzSG72F8WWU4LODsrNtHwMsB1zTKwVcxezGORnC9oI13LX1rFejGn
         qGYTQwEJL0Qzz8StcBls/GWQOkkbVF/T3DO+fyR9CWi7pcBQrkSgNOqwA3tCOhpRLovv
         G1qA==
X-Gm-Message-State: AOJu0YwRIY8UwTy2uTGSPQvp6Q0ymWqHi1zSfRbcvks5euGiw35bt6tT
	40oAG5y7OvIun1zLoGbGvOC0MJqJKNEpGQ==
X-Google-Smtp-Source: AGHT+IG4/u9bmxoWCQgWEb+IxIitQY+Jqk27uGUvwtrEDLlmMJ5zol/qywAJYHJRxS1K7m+SYsgO9g==
X-Received: by 2002:a05:6870:b48b:b0:204:2ea8:3f41 with SMTP id y11-20020a056870b48b00b002042ea83f41mr9561336oap.52.1703802011559;
        Thu, 28 Dec 2023 14:20:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id j26-20020a62b61a000000b006d3b7f40292sm8644148pff.19.2023.12.28.14.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 14:20:11 -0800 (PST)
Date: Thu, 28 Dec 2023 14:20:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Greenman <gregory.greenman@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: Fw: [Bug 218330] New: wifi bug
Message-ID: <20231228142009.0883d2a9@hermes.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Thu, 28 Dec 2023 21:54:40 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218330] New: wifi bug


https://bugzilla.kernel.org/show_bug.cgi?id=218330

            Bug ID: 218330
           Summary: wifi bug
           Product: Networking
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: 1bdou.charik@gmail.com
        Regression: No

Created attachment 305670
  --> https://bugzilla.kernel.org/attachment.cgi?id=305670&action=edit  
wifi bug

https://pastebin.com/QKgPALG8 , hey there there is output after i click the
wifi icon to turn it off on fedora . my  device is : 02:00.0 Network
controller: Intel Corporation Wireless 8265 / 8275 (rev 78) and 


uname -r : 6.6.8-200.fc39.x86_64

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

