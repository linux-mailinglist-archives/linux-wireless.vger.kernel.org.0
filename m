Return-Path: <linux-wireless+bounces-7365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8898C069A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 23:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC66428279A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 21:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2154F225D9;
	Wed,  8 May 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="O0Ppjs9a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC14D530
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205215; cv=none; b=YHyU4xa9i7RSUXDu6p+MbO1YDb4pNp9d9+84roZJS3cJfYtkN7y0sT8bEaEG0TS31eCcb0qQu0VoJh0u7whz4xhqbtTiJPNWT8sjcXM1pQCMVumTPMnT/ckcWNcnVy9LVpSbxsiibaqvPaJNHAQRrUF4D/je0tN9tTNQ1dll4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205215; c=relaxed/simple;
	bh=gwLxRDf9CZYMGXuoTSjyVf48KNAUdRF/A9q9P+lIZnU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qQZdFVkkOYplnCiXaxDLZrt82VbZLKVh7GU02tO42TEsFLDLt1StUge0yGyBgsxojoI/BmetuGFhZcia/HrrZKqoKFYJZK6ZJSdq0iwaC1t3roF0X4kGkZKdBjCs+TCDcj5uuund82HePwZPlHYSiga/YYy8hkDqnRPuOIoGBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=O0Ppjs9a; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f1e8eaee5so1215627e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1715205211; x=1715810011; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O0S69j79eBYhmBMbT4hJ1Z4Uet01OsoG5wWnNegmucA=;
        b=O0Ppjs9ayk7HQNS9rUSAYE7I98QV1Vf6+c4i0bHCz1b2mvLktr6/hGODeLhxrJ1l5T
         HNC0ELOSlLRIeY+AI/trcY8fbAQ3ECEG+EjLYH7jAM/Gu7ndYML27YuMSP0fNueX9u/C
         9CwKiPF/r/6vNW61xoSFnw6uGXnIIIolds4BKtyKufpgNGv5V0WfNTMZymJP6BMGcnS3
         t70RJ8Sm0LIR4xRoOQtx9W8bL3sqktJkGW0uTEXSyv7H3wODosQS1CXr7YfBtCQ+yPWD
         o9pfikECfCBsY7trj45JlFQ3E/DrEOBs5WBYJ/BqxZtm4ZhBL4TQMJD8kc4SW19L0+ws
         XQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715205211; x=1715810011;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0S69j79eBYhmBMbT4hJ1Z4Uet01OsoG5wWnNegmucA=;
        b=XIaZDuwqg5TyEYjuhRZ9OR3Epu2/ln8h2RagTmPu14ny/ThQ7w8oBv0KLVuwGcKnsa
         xlvzbWp9G/yPAVr5c3iDq2+oIkmD4irLbL9kXIvvwg8Lu+jksvNgidci1cs/ci7wpys7
         ulm5SreVNQUpV3dicCf0Ak0U5H7UWqH5iTxH7nmZ0W4CRB//ax/QnG0UDrLdAueG1CF3
         5Lffpizpnk5YMO9MKiTC5oCexukI2GPNhoPH6z17eMXJhWk5bKdMbjubq2sOooRwHUsM
         YkO48X5/WqqWYcgE6JnD4q+lVCbWCuvGvUI0p574WE8r66NJClc+znWJ/chSlDiPGkWT
         YQYg==
X-Gm-Message-State: AOJu0Yy+3k1Ql3VFLT6T1Epl4RaHnVCsxpBdtdWtstiL9AWaaHR1JFjp
	saG9Vt2KmjRQfpU+IrHr5ietsOEtwKqcLm3oLseVFBK2TJVWw0KU1n93g0sw9YlYi02BRizieht
	eokH8Vxj4ZOmEtg3S4LNoetggmRbOsvr/cR4d/uda0fa7+vfrqpk=
X-Google-Smtp-Source: AGHT+IGGS5s0cmVJ5xACWr7C+eEuR9u5DoQsyQKZRs6tBMYCfhdE3/ZY9jEbTOw0jgz0hQ2TXHy7DKnw65JrETV3N20=
X-Received: by 2002:ac2:43af:0:b0:516:c97d:96b4 with SMTP id
 2adb3069b0e04-521e095fbe0mr215713e87.2.1715205211125; Wed, 08 May 2024
 14:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matt Hartley <mrh@frame.work>
Date: Wed, 8 May 2024 14:53:20 -0700
Message-ID: <CAFR8rtBZPAU9j2k_YLK36memrm-Tj0XFSZnkUyw2Hd-mw=vsxQ@mail.gmail.com>
Subject: Wireless slow down on MediaTek MT7922 for Framework Laptop 13 AMD Ryzen
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings folks,

We are seeing multiple reports from those on Fedora 39 and Fedora 40
that they are seeing significant wireless internet speed reduction
from previous firmware release for the MT7922 wireless card.

[ 28.870498] mt7921e 0000:01:00.0: ASIC revision: 79220010 [
28.950129] mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20240219103244a [ 29.342888] mt7921e 0000:01:00.0: WM Firmware
Version: ____000000, Build Time: 20240219103337

Testing indicates this is not a problem with region or power savings.
I'd welcome any insights you may have.

-- 
Matt Hartley
Linux Support Lead
Framework
https://frame.work
https://community.frame.work/

