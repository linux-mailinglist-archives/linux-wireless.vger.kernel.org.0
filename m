Return-Path: <linux-wireless+bounces-30047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E92CD5A8E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 11:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44E0E3029C7B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948A9219FC;
	Mon, 22 Dec 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiPIsedT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F96274FEF
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400519; cv=none; b=rl9tFwxp5sUQcBGPltqXopMSpR//g3as4dmEiM3KrEgLzGIUAU8S67mQ9E26eGlg0Qw3WAQN/JDfYudK4HQPjCopVoKEAmLyoFDbmj4lR4sCJkIyJjoXAvXgAk33NpDq/OwtMWmPfV/spyBSbPpuXSy8WtuFbP9sTNApRNJuIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400519; c=relaxed/simple;
	bh=j6FZratqdFQOa7GoeQVH2mjn+V93F9s5buYfuqWEg3k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fqxVJa1PoI/Uf7rk3mg6pC5NJxUg8qur65483HTSSr+FbQOkYl07b6unYeMW6EhVDbvvsPhdzart/A/TOYbFoIgz5zUQoOO5rbRG3eUn3PRQabwhQrsHc5y8xIgdACvKVvophjeC7m+Urg9A9VceZaYP3rQRjl6KUZHCirtPY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiPIsedT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso26018435e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 02:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766400516; x=1767005316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6FZratqdFQOa7GoeQVH2mjn+V93F9s5buYfuqWEg3k=;
        b=JiPIsedTeGSG7iHQcJLkDqvklMzgHvQDFvCxhxXJe+eW8qfVhcbXgGHw12KCsOFks/
         1E10bNJAbI3WwKZ6/65HF+XpKM8nbS1+wsc3H6eWbbbunesCDDAZAPSqTOpj8CE4mgeo
         75jjYAJ7sbN16Ts29a+SdekOqT3t196ckvOUu9jxIKZR5kSHjf/d7tb/B6o1jgH/BKLF
         p1xmciw29e4bQEKGNrw7hVdEEbkLdz9zBxhIZiICo33ETSG26N8i34O2OZ2cKnpwIHDt
         b9xoNuHl5JI4nJVtB5TiZ/iEynUWLDsowXcOU1fIRPdG/BOoGjeVilJLPhRZmgL9henz
         6X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766400516; x=1767005316;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6FZratqdFQOa7GoeQVH2mjn+V93F9s5buYfuqWEg3k=;
        b=ox5LkMVJ6xb2z2bawysklOnN8frGd66AB7OUgmoF1Svn093CB5gMDKIV18om6wepGv
         M1WIDlX/5yG7cGWA+fcaciwwX9Oc/hqfrulK6RfvSwZKCPgnTlpIvmaNRJXGzCZHqL6G
         eGYFNFto4IV+gA907rXNX7h/I/abVI73rvCQSlGUIi5oJgvKkx1l3yAq9Dm48tX93uya
         GNlv+EJ2j+GwHQtY4QHla8FDs+hDvwrPfFTFgEyLcDuEIOq0MQ8jyRWK1UjZEetmCnQc
         BZJ+2/Rt1pqAQkAVkl7fNhOGpH1e6V6bHTFMSFIF3zKTu12HHiftRfylfapNFzE4sBbJ
         zgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj80WHQJ6bxEudCSmr9LHQIH9Q3VG21PTHCXzQXaagN15UG0TUjt8h6AbCktpt8CcpbrELogDjz9BUvVfJoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5glEqWFuRNkZUz07sPDpVcvuOOH+RHYJg8mExgpTUM2cglPRk
	oa8eLbF4oaaCcKuZ5T5lA1zuMxxZj5gHNqDYIIuWcXmEYjQ4drwEP4Zs3ZoTnEZG6z6wEmadls/
	n0gK6imxMKckskLAVU0Wdpb4YUiFVzc0=
X-Gm-Gg: AY/fxX4RsjwqNhV15zw3zN7wWu9Kq0Vs+8yax4V3JndK66KsiGDB2mEmMylUH90euA6
	5c2IIllsZtUTkxmgtQphL9yRwvrdGck1i15HaUUSIt/3LwqUGjn5lYVU5RDot+GPhU31Htwcr+x
	AHLPaGPLvGkiFWEEyQbMVSg11zSV+VluxUbN6G910N7Ifn0GSfZZpgHkHs9ftkWCjOnVsqvpE41
	0ZQnyb8WGgSbHJEDxdQVzSs64CsvjbCb8bP5Kz4RWEl5X9NcKUkVUqJD+J6Nm6BWt/y
X-Google-Smtp-Source: AGHT+IG9WeADbQK9PZxeAuT6zGqXVrJnE5JXCMJenf1O1pVTVOWiiKhNJRkSUdMl5apSCRSBEULtP+4AYoVrG+drPjU=
X-Received: by 2002:a05:600c:35d1:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47d1954a165mr125333545e9.15.1766400515972; Mon, 22 Dec 2025
 02:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Filippo Rossoni <filippo.rossoni@gmail.com>
Date: Mon, 22 Dec 2025 11:48:24 +0100
X-Gm-Features: AQt7F2pBRYihAG2s2l6Rnh9inlqS58_9X_IjzMf6B47ADfIYMoOsRScq77cybbU
Message-ID: <CAL2NpJxittExeKX42oMr6+b4Y306nBOtxOxiupLwsPi7w=aA=Q@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: Fix strscpy buffer overflow in mt76_connac2_load_patch
To: matthew.schwartz@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo@kernel.org, 
	mikhail.v.gavrilov@gmail.com, nbd@nbd.name, superm1@kernel.org
Content-Type: multipart/mixed; boundary="0000000000004939d40646882b34"

--0000000000004939d40646882b34
Content-Type: text/plain; charset="UTF-8"

Hello
What is the status of this patch
I'm compiling the latest kernel with this patch to have wifi working
The current status in not working if there are problem with this patch
I propose to revert the commit
[f804a5895ebad2b2d4fb8a3688d2115926e993d5] wifi: mt76: Strip
whitespace from build ddate

--0000000000004939d40646882b34
Content-Type: text/x-patch; charset="US-ASCII"; name="wifi.patch"
Content-Disposition: attachment; filename="wifi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mjh141f30>
X-Attachment-Id: f_mjh141f30

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25u
YWNfbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFj
X21jdS5jCmluZGV4IGVhOTkxNjc3NjViMC4uMGZiZmE0NDlkNmZlIDEwMDY0NAotLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5jCisrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmMKQEAgLTMx
MDEsNyArMzEwMSw3IEBAIGludCBtdDc2X2Nvbm5hYzJfbG9hZF9wYXRjaChzdHJ1Y3QgbXQ3Nl9k
ZXYgKmRldiwgY29uc3QgY2hhciAqZndfbmFtZSkKIAlpbnQgaSwgcmV0LCBzZW0sIG1heF9sZW4g
PSBtdDc2X2lzX3NkaW8oZGV2KSA/IDIwNDggOiA0MDk2OwogCWNvbnN0IHN0cnVjdCBtdDc2X2Nv
bm5hYzJfcGF0Y2hfaGRyICpoZHI7CiAJY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdyA9IE5VTEw7
Ci0JY2hhciBidWlsZF9kYXRlWzE3XTsKKwogCiAJc2VtID0gbXQ3Nl9jb25uYWNfbWN1X3BhdGNo
X3NlbV9jdHJsKGRldiwgdHJ1ZSk7CiAJc3dpdGNoIChzZW0pIHsKQEAgLTMxMjUsMTIgKzMxMjUs
MTQgQEAgaW50IG10NzZfY29ubmFjMl9sb2FkX3BhdGNoKHN0cnVjdCBtdDc2X2RldiAqZGV2LCBj
b25zdCBjaGFyICpmd19uYW1lKQogCX0KIAogCWhkciA9IChjb25zdCB2b2lkICopZnctPmRhdGE7
Ci0Jc3Ryc2NweShidWlsZF9kYXRlLCBoZHItPmJ1aWxkX2RhdGUsIHNpemVvZihidWlsZF9kYXRl
KSk7Ci0JYnVpbGRfZGF0ZVsxNl0gPSAnXDAnOwotCXN0cmltKGJ1aWxkX2RhdGUpOwotCWRldl9p
bmZvKGRldi0+ZGV2LCAiSFcvU1cgVmVyc2lvbjogMHgleCwgQnVpbGQgVGltZTogJS4xNnNcbiIs
Ci0JCSBiZTMyX3RvX2NwdShoZHItPmh3X3N3X3ZlciksIGJ1aWxkX2RhdGUpOwotCisJeworCQlj
aGFyIGJ1aWxkX2RhdGVbc2l6ZW9mKGhkci0+YnVpbGRfZGF0ZSkrMV07CisJCW1lbWNweShidWls
ZF9kYXRlLCBoZHItPmJ1aWxkX2RhdGUsIHNpemVvZihoZHItPmJ1aWxkX2RhdGUpKTsKKwkJYnVp
bGRfZGF0ZVtzaXplb2YoaGRyLT5idWlsZF9kYXRlKV0gPSAnXDAnOworCQlzdHJpbShidWlsZF9k
YXRlKTsKKwkJZGV2X2luZm8oZGV2LT5kZXYsICJIVy9TVyBWZXJzaW9uOiAweCV4LCBCdWlsZCBU
aW1lOiAlLjE2c1xuIiwKKwkJCWJlMzJfdG9fY3B1KGhkci0+aHdfc3dfdmVyKSwgYnVpbGRfZGF0
ZSk7CisJfQogCWZvciAoaSA9IDA7IGkgPCBiZTMyX3RvX2NwdShoZHItPmRlc2Mubl9yZWdpb24p
OyBpKyspIHsKIAkJc3RydWN0IG10NzZfY29ubmFjMl9wYXRjaF9zZWMgKnNlYzsKIAkJdTMyIGxl
biwgYWRkciwgbW9kZTsK
--0000000000004939d40646882b34--

