Return-Path: <linux-wireless+bounces-28286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72A9C0B03B
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 19:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536743B4362
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE18F2F0C7C;
	Sun, 26 Oct 2025 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="m1Ow9j43"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3492ECD1B;
	Sun, 26 Oct 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761503282; cv=none; b=eM1EFFJpIKGFS/FCw+7z/YiUWxRhSr1FQLSU2ueAL5b9KJwMet/RUieVHSF8FLfz7Tx2Gnx/r+cys8RLgPwM41GMxH5P3nY9xUKoD1FMm1HLm5ZAGiMPOjmoj/KsqL80QkL63M5CzYXnZq9ROJ7Gbaux32oEHwHZb2P2Jha+UgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761503282; c=relaxed/simple;
	bh=dxiZgUshidiunzeesXzbevM5oc8Zm0k3O9Y4h0w5UVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tqSxAUHhssPDqyt+XsGzwalxzzDizPQE53osPsX6ubPrZfywJl9YB/6oa6M7h46W7SlV50W+Yz6iDXMkBZ1GbCN1/8Zj89dbsQPULrIwAkg3usWigag2AK0sjzBImmkJmvh/UPrugfiO3xaDZv7hBQG7WkqUZfMS6X2JyGT4MxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=m1Ow9j43; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1761503215; x=1762803215;
	bh=pZPnNNIfItaWXhurcxi0vMwTs0Lsqn4l/evDT63v+Tw=; h=From;
	b=m1Ow9j43CkZe4whqZREYpOs3d9RDjJCdpxl5z9mrSQVff0Do01TZnF+fqBHpDCJws
	 qH2MTfrk1F5yiBJdABNlryHZYp6GQoLOVvoMdMAjP72/l7JmugIdhtpiTI6mL45whm
	 Kk2rSBeN45f1OLms7vpUmHrgHjAI7KO4DI+YnalGOuc/2xgIsknY7mfM/zgtx3dDD5
	 td+gKlUG5VB2nagLl08ctJF7CnKQ1f/QUuhZEDV4TA59pFNDK6l/fu8J2etHq3BL6q
	 DKljwsIApQCGRztx1napPsTduJ9GaGMi/ovsRxfnKAh27mve3QIMPNj2LZ/xM4WtS5
	 mRskW/PdYhnCg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 59QIQqnR043047
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 26 Oct 2025 19:26:53 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>, Jeff Chen <jeff.chen_1@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for samsung,coreprimevelte
Date: Sun, 26 Oct 2025 19:20:37 +0100
Message-ID: <20251026182602.26464-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

this series adds support for WiFi to the samsung,coreprimevelte
smartphone (and can be straightforwardly reused for the other known
Marvell PXA1908-based smartphones).

The series is currently not intended for application as indicated in the
subject prefix as the firmware necessary for the operation of the chip is not
available in linux-firmware.

Instead, my intentions are to publish the recent developments regarding
the chip support (see the third patch of the series) and offer them for
others to use and if possible get some feedback on them and also
hopefully to spark some conversation with NXP regarding getting the FW
into linux-firmware which would allow this series to be mainlined.

Regarding the firmware I have been in contact with Jeff Chen of NXP some
time ago who promised to ask about it internally – I am thus now gently
reminding Jeff of the matter. I will also appreciate input from anyone
else who may help with upstreaming whichever version of the firmware.

The trouble of upstreaming the FW is mostly a legal one (although an up
to date version of it would also be very welcome) as it is available as
part of the stock Android of the devices with this chip and can thus be
used on individual basis, it cannot however be submitted to
linux-firmware by myself for instance as the license is not known
(although probably is the same as for the other blobs in the mrvl
directory) and as the submission would require a sign-off from someone
involved with NXP.

The third patch in this series fixes a serious issue with the WiFi
observed on the phone (see the relevant commit message). The form is
however not directly usptreamable and it is not clear to me how to best
make it be since it involves changing a data type which probably cannot
be easily be special-cased for the new chip and would likely break the
other chips the mwifiex driver supports if applied as is. I will thus
welcome suggestions on this, although I'm also hopeful that a possible
reasonably up to date FW would not require this workaround at all.

The series is based on the pxa1908-dt-for-6.19 tag of Duje's tree [1] as
it contains the necessary SDIO description in the phone's device tree.

I have not applied the trailers sent in response to v1 as it has been
some time and as this is not expected to be applied anyway.

[1] https://gitlab.com/pxa1908-mainline/linux/-/commits/pxa1908-dt-for-6.19

Cc: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>

v2:
- Rebase to Duje's tag.
- Add a new patch fixing observed firmware crashes.
- Link to v1: https://lore.kernel.org/r/20231029111807.19261-1-balejk@matfyz.cz/

Karel Balej (4):
  dt-bindings: mwifiex: document use with the SD8777 chipset
  net: mwifiex: add support for the SD8777 chipset
  DONOTMERGE: net: mwifiex: fix timeouts with the SD8777 chip
  arm64: dts: samsung,coreprimevelte: add wifi node

 .../bindings/net/wireless/marvell,sd8787.yaml |  1 +
 .../mmp/pxa1908-samsung-coreprimevelte.dts    | 15 +++++++++++++
 drivers/net/wireless/marvell/mwifiex/fw.h     |  4 +---
 drivers/net/wireless/marvell/mwifiex/sdio.c   | 21 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sdio.h   |  1 +
 drivers/net/wireless/marvell/mwifiex/sta_tx.c | 10 ++-------
 include/linux/mmc/sdio_ids.h                  |  1 +
 7 files changed, 42 insertions(+), 11 deletions(-)

-- 
2.51.1


