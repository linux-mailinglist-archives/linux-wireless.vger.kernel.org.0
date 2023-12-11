Return-Path: <linux-wireless+bounces-654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E51980C794
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC682816A8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF52D625;
	Mon, 11 Dec 2023 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfN0uLHE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3025A1
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702292540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6s3YEkS59zuD6SVaNNZ9gLtFuddKXIASd6iTW1OMc6Y=;
	b=gfN0uLHE172xVtYxTCCOnqYGFb9Qfi97Rb5fcFwbhXo8DFupQzh+MmVgiHyYWUwzzC3zO9
	sc3McrVjpiMtiJ/CxlGwy5B2yk5JZ7d24a3Xo5/NOUC7VNBDE0MFmFkt4bs0cP5gndMAYN
	daHyfPOeRvtnG4q3Z6INmYRVNreG1Kk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-QW3CHGPrPXeUMD1EdWEahw-1; Mon, 11 Dec 2023 06:02:19 -0500
X-MC-Unique: QW3CHGPrPXeUMD1EdWEahw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54f492cda78so1548236a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 03:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702292538; x=1702897338;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6s3YEkS59zuD6SVaNNZ9gLtFuddKXIASd6iTW1OMc6Y=;
        b=pqKPgMxh8FVI6FMQBDW0AD3MZQAW7v8lBW9h6WWr5BfT/0JrT3lK9j0B+3rGbd+RUE
         Q9EzK+PJWCvVBkVCJwMrxrw4ubrmceYFrstQ9PSSGuaYm9YRjcrEC/IPrewoTZdrGM8X
         kFyfsL19d1UFdtmdxfS+qgasOYvt8Jx+2kbke9v1I/BJOuBIsCH9nqRMloGZOScbBZjn
         6jotJdHdwDWQ4f6G13RHg76CBKJAITiNSuBrKbG24f/kDgZCWHb/53KxIFWaZQSQ7ai8
         qnmRzE/V2P0xIXpEofVD1IBU1lrlRgF84F7ZagCtw6Wd0OlynuAnKHnj/Vyy1IQTM8M5
         wf0Q==
X-Gm-Message-State: AOJu0YyzgOPxUyNDaKeRipSoGsSL3E7/vj1uVat1aTopEKgQ9QUsfmLi
	T0qqlMbjdZyVxueUOxo+boqFBhFG9bvYLIlrYqJasF3pgA0Sl92L6OXWgKqUmwfcBg6g9B6oP/R
	fedlvB1hC+1ISCsCHtOrKq2/P23k=
X-Received: by 2002:a50:99dd:0:b0:54b:1a4c:8711 with SMTP id n29-20020a5099dd000000b0054b1a4c8711mr2325951edb.2.1702292538392;
        Mon, 11 Dec 2023 03:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/AgpHdfGR5nI/doFi+LibDrDycEv4PqF42QX5UBnnwO0XzaH8cQZnrQQZUPOkkdB9Rw4Yyg==
X-Received: by 2002:a50:99dd:0:b0:54b:1a4c:8711 with SMTP id n29-20020a5099dd000000b0054b1a4c8711mr2325938edb.2.1702292538091;
        Mon, 11 Dec 2023 03:02:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b0054cb316499dsm3489357edi.10.2023.12.11.03.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 03:02:17 -0800 (PST)
Message-ID: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
Date: Mon, 11 Dec 2023 12:02:16 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl
To: Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi /
 amdgpu due for the v6.8 merge window
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Wifi and AMDGPU maintainers,

Here is a pull-request for the platform-drivers-x86 parts of:

https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/

From my pov the pdx86 bits are ready and the platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the amdgpu driver changes on top.

This only adds kernel internal API, so if in the future the API needs work that can be done.

I've not merged this branch into pdx86/for-next yet, since I see little use in merging it without any users. I'll merge it once either the wifi or amdgpu changes are also merged
(and if some blocking issues get identified before either are merged I can prepare a new pull-request fixing the issues).

Regards,

Hans



The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-amd-wbrf-v6.8-1

for you to fetch changes up to 58e82a62669da52e688f4a8b89922c1839bf1001:

  platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature (2023-12-11 11:33:44 +0100)

----------------------------------------------------------------
Immutable branch between pdx86 amd wbrf branch and wifi / amdgpu due for the v6.8 merge window

platform-drivers-x86-amd-wbrf-v6.8-1: v6.7-rc1 + AMD WBRF support
for merging into the wifi subsys and amdgpu driver for 6.8.

----------------------------------------------------------------
Ma Jun (2):
      Documentation/driver-api: Add document about WBRF mechanism
      platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature

 Documentation/driver-api/index.rst |   1 +
 Documentation/driver-api/wbrf.rst  |  78 +++++++++
 drivers/platform/x86/amd/Kconfig   |  14 ++
 drivers/platform/x86/amd/Makefile  |   1 +
 drivers/platform/x86/amd/wbrf.c    | 317 +++++++++++++++++++++++++++++++++++++
 include/linux/acpi_amd_wbrf.h      |  91 +++++++++++
 6 files changed, 502 insertions(+)
 create mode 100644 Documentation/driver-api/wbrf.rst
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h


