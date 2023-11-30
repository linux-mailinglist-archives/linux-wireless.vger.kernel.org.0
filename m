Return-Path: <linux-wireless+bounces-229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B07FE677
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 03:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D0D2820B6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 02:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB96749D;
	Thu, 30 Nov 2023 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9E10CE;
	Wed, 29 Nov 2023 18:03:32 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fa619735c1so207750fac.0;
        Wed, 29 Nov 2023 18:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701309812; x=1701914612;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Q2vNmGuGh5CrrcXwq2zhKRBlmkvD1yCFiwOjfu4SPE=;
        b=oisCcIh9XQ0mDGa45Yzn/+14pwhVHbzkYRpWYH7+qluJTmZ56yIJAaY0TCgxqn6hkw
         0IaNJNIYM0s0AJGYGbjOJl5z4MJ33/W1334R1thzDSX4w7ax+HY58b+zewbBAXuDIC+N
         nKet4NT1e1VGQBCaDXYUVK7ZH8IEdUITQZycwCUlmYEJWDT6WVg7T5ee07HsO2YmCp50
         LUECLCswXjvcZHXsZqo9sMZtgMIS9obE+3j9kC7Tr3IxlYaaujtW97wjSyQDvtGCrYE0
         87+XecosiyuuYiHjYIDuhly6wL+0sgyYs8UgDHoj2Xd14capzALIm5k9EOWDE4Vck6Cx
         xhkw==
X-Gm-Message-State: AOJu0Ywlpt7z0Lyzrc6lbysR7+Sm+2ZaUb0ju9b6rf2RafsgaW3/RtpH
	lPMy2aMXPN7zFdxMXim7SZkIRVqVEt+6I5kKRqc=
X-Google-Smtp-Source: AGHT+IFeBw5C9KhItRvNqkQlIigQafVlG4P8xPVIFw8uY++6NCKs10HkkZbCf246Q6s6P9IIzfZpjTtKmOGok6pCVqU=
X-Received: by 2002:a05:6871:2309:b0:1ea:2c8b:e18b with SMTP id
 sf9-20020a056871230900b001ea2c8be18bmr24543836oab.35.1701309811728; Wed, 29
 Nov 2023 18:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Wed, 29 Nov 2023 21:03:20 -0500
Message-ID: <CAJvTdKkcxJss=DM2sxgv_MR5BeZ4_OC-3ad6tA40TYH2yqHCWw@mail.gmail.com>
Subject: iwlwifi: WRT: Invalid buffer destination
To: Johannes Berg <johannes.berg@intel.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Gregory Greenman <gregory.greenman@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Automated suspend/resume testing is grumpy about iwlwifi, because
iwlwifi dmesg's with the words "Invalid" and "Failed", which our
heuristics highlight as issues a human should review.

If this is normal, can you delete the messages?  If this is a failure,
can we fix it?

thanks,
-Len

[20168.810433] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[20168.967756] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[20168.967806] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[20168.967857] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[20168.967919] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[20168.969387] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[20169.074918] iwlwifi 0000:00:14.3: Failed to create debugfs
directory under netdev:wlp0s20f3
[20169.076354] iwlwifi 0000:00:14.3: Failed to create debugfs
directory under netdev:p2p-dev-wlp0s20

ps.

lenb@lenb-Dell-XPS-13-9315:~/src/linux$ grep IWLWIFI .config
CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
CONFIG_IWLWIFI_DEVICE_TRACING=y

