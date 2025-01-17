Return-Path: <linux-wireless+bounces-17659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3AA15625
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 19:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0113A1570
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802191A3BC0;
	Fri, 17 Jan 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ4BLVfB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747B1A2643;
	Fri, 17 Jan 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136795; cv=none; b=mIkHxvOHsJ82uQ7t3d1cdsktrHYrgLQsK4ATy/elV36Wz5KKWiDQ8nJDu1z1A+zGK4DBZXLm1wEn1r0VbMP5DPuMKE9sgEDdhiWPSPHjS9naKjwy9R5eIWXgPbKTjfZ44jrAWuoS+FJyDb1GKuEQn0s8EWFXLI8xAwsqWq2Wleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136795; c=relaxed/simple;
	bh=GbqeT7eeAHIjJRdLRDZggAAJcM/bUobSgiiZNrAeh2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkS3kZ4HVGEP/SwM1sn0EpBS0u/tKFezh1qzI7uECH8wGoZVrjCRdzzJ7m3icruu6b3oj7HMpHynCDAyUQ4lcXvHrCFGjmuYYJ+FFH5qpSU5/9s0OmVJuL3FbrTfqQO+fjQ+oD5FFnVakNujLxNaXjVc6pcFgAl2jQWx0UOnhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ4BLVfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FDAC4CEE2;
	Fri, 17 Jan 2025 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136795;
	bh=GbqeT7eeAHIjJRdLRDZggAAJcM/bUobSgiiZNrAeh2s=;
	h=From:To:Cc:Subject:Date:From;
	b=UJ4BLVfBc5CgoQgarhyz8frZd3QYr1vcDc2Q23SSXR+RqDZQtU/odh+ZiYIU39zNC
	 4Goye5M2FBfXHDElyZQ7t1tD2NWBMpzpZmfcf9XIpBWH4maYz2EhpE7hLxjaKdW9Ti
	 Dm3xEBD0kdXOMipbvNS5HVNC1tSBM0ufLIFAeVkQf6CBKC3EtCxwJNQyfEKeoKXOY5
	 7CEBYMrCHsZabraQCo0XylISR1P8O2ATNSp57I8fO0WzV5AIvXNB89q4L/mh8J4zPB
	 cZVttfxstovxydmK5i+zItsh6M/7UCwzlpHwCX1pueQUgv2Awf3n4imiO0Oj2vRDAY
	 6+sBgdQWecUsQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tYqdM-00000006AjU-1Ray;
	Fri, 17 Jan 2025 18:59:52 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Chao Yu <mchehab+huawei@kernel.org>,
	Jaegeuk Kim <mchehab+huawei@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mike Leach <mike.leach@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC 00/10] Improve ABI documentation generation
Date: Fri, 17 Jan 2025 18:59:29 +0100
Message-ID: <cover.1737135484.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon/Greg,

The main goal of this RFC is to give a heads up of a work I've been doing to
replace the get_abi.pl script with a python version.

Patches 1-6 are OK to be applied:
- Patch 1 changes the sort criteria of the ABI generation to use alphabetic order:
  currently, it is *almost* alphabetic, but, on some cases, it orders on a different
  way. No changes at the content, just at the order. 
  I wrote it mainly to use the same sort criteria as the new tool, but IMO it is
  worth applying even before we switch to the python version.

- Patches 2-6 fix some ABI tag problems. They're independent of the rest and
  can also be applied without  other patches on this series.

The remaining patches (7-10) are RFC for a new tool.

The new tool uses a cleaned-up version of the same algorithms I wrote in Perl,
re-writen in Python. While doing the conversion, I got rid of some stuff that aren't
needed anymore.

The new tool has two additional changes:
- the validate tool now detects a duplicate definition when files with the same name
  exists on different parts of the ABI documentation (if one asks to build them altogether);
- it fixes a bug on one of the files whose "what" keys weren't properly parsed.

Patches 7 and 8 are already in good shape (IMHO).

Patch 9 replaces "get_abi.pl" by "get_abi.py" exec for htmldocs/pdfdocs targets.
It is not on its final shape, as my end goal is to do a python include and use the
class directly there instead of calling an exec file, but such change will require
some work (I'll likely implement an interactor at the class instead of just returning
a big amount of text).

Patch 10 is just a boilerplate to one additional functionality of the perl script that
would require a lot of work to implement: check undefined/bad defined symbols
at the local machine's sysfs and compare with ABI.

Before getting patches 7-10 merged, I'd like to implement patch 10. This may
take some time, as the ABI check there is not the simplest code I wrote.

Yet, I'd like to get some feedback about patches 7-9 while I'm working on 
patch 10, so, let me send what I have so far as a RFC.

I hope this would make more people look at the code, as right now, we had only
6 persons/6 patches besides me that touched the code.

Mauro Carvalho Chehab (10):
  scripts/get_abi.pl use label to better sort ABI symbols and files
  ABI: sysfs-class-rfkill: fix kernelversion tags
  ABI: sysfs-bus-coresight-*: fix kernelversion tags
  ABI: sysfs-driver-dma-idxd: fix date tags
  ABI: sysfs-fs-f2fs: fix date tags
  ABI: sysfs-power: fix a what tag
  [RFC] scripts: add a get_abi.py tool to generate ReST output
  [RFC] scripts/get_abi.py: add support for symbol search
  [RFC] docs: use get_abi.py for ABI generation
  [RFC BOILERPLATE] scripts/get_abi.py: add support for undefined ABIs

 Documentation/ABI/removed/sysfs-class-rfkill  |   2 +-
 Documentation/ABI/stable/sysfs-class-rfkill   |  12 +-
 .../ABI/stable/sysfs-driver-dma-idxd          |   4 +-
 .../testing/sysfs-bus-coresight-devices-cti   |  78 +-
 .../testing/sysfs-bus-coresight-devices-tpdm  |  52 +-
 Documentation/ABI/testing/sysfs-fs-f2fs       |   4 +-
 Documentation/ABI/testing/sysfs-power         |   2 +-
 Documentation/admin-guide/abi-obsolete.rst    |   1 -
 Documentation/admin-guide/abi-removed.rst     |   1 -
 Documentation/admin-guide/abi-stable.rst      |   1 -
 Documentation/admin-guide/abi-testing.rst     |   1 -
 Documentation/sphinx/kernel_abi.py            |  10 +-
 scripts/get_abi.pl                            |   3 +-
 scripts/get_abi.py                            | 678 ++++++++++++++++++
 14 files changed, 760 insertions(+), 89 deletions(-)
 create mode 100755 scripts/get_abi.py

-- 
2.47.1



