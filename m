Return-Path: <linux-wireless+bounces-19487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF3A4647C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 16:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB80163B67
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A535968;
	Wed, 26 Feb 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onet.pl header.i=@onet.pl header.b="PZjV9AUe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpo92.poczta.onet.pl (smtpo92.poczta.onet.pl [213.180.149.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649C21519B
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.180.149.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583430; cv=none; b=cpoyMTpYJRhrhgR+wN2LzKcd57uyvZ2cya3JaQRew0zXH8i4MvzDmkbVKbVikLEfakbFV8VzAa4RsF7YAXUx2dwNTmePt3viugPxiZ5qryMdSyn+yBnhQhc7jqzGMMK6kdX0KocAGf0qQ7BLtg8K0Ck7e+CWhWWXbg5aGVLmdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583430; c=relaxed/simple;
	bh=psmCIxILVrSlvKN6uc1XX2DuSOpdIg3jbS1hoKUqPFU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fTZ5qfTJ0o8s+Ema/WbgLqPSqz3W0bESmOKtSbKbn2H/VxJyXo8xWwyxhdC1LhcWKhOpdj2QJcP0cE/fVhbKMsG1xRbOhOfR5LHINEpAolkq/G2lb6EgJ/G1NipNk4rlq5pv9+KDkqopyJWQahNylTQICbsKyrbbRnHjubCcbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onet.pl; spf=pass smtp.mailfrom=onet.pl; dkim=pass (1024-bit key) header.d=onet.pl header.i=@onet.pl header.b=PZjV9AUe; arc=none smtp.client-ip=213.180.149.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onet.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onet.pl
Received: from DESKTOP (unknown [94.40.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukasz.michalski@onet.pl)
	by smtp.poczta.onet.pl (Onet) with ESMTPSA id 4Z2ysy0mrqz1y3Q;
	Wed, 26 Feb 2025 16:23:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onet.pl; s=2011;
	t=1740583415; bh=psmCIxILVrSlvKN6uc1XX2DuSOpdIg3jbS1hoKUqPFU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=PZjV9AUewiK9q266EJUroBAZP5oql6VCR/poou0rIryKbqyRyKKwkUFR3yIcCE7A2
	 pi2rngfDuArdk3eWHjq1WmHxG1RqKv8y4lDA/aIAr7dh4V5GNjBh9fl7ChtgLEjS+g
	 r8TmNiSKtJvKjsanttrtYp1gEEaPFutKFGQCXbvk=
From: <lukasz.michalski@onet.pl>
To: "'Felix Fietkau'" <nbd@nbd.name>
Cc: <linux-wireless@vger.kernel.org>,
	<lorenzo@kernel.org>
References: <003401db8476$348684c0$9d938e40$@onet.pl> <da6e61d7-0457-43d6-8ce9-a5a94ecf431a@nbd.name>
In-Reply-To: <da6e61d7-0457-43d6-8ce9-a5a94ecf431a@nbd.name>
Subject: RE: wifi: mt76: mt7915: fix broken background radar implementation
Date: Wed, 26 Feb 2025 16:23:29 +0100
Message-ID: <003601db8862$65a75800$30f60800$@onet.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: pl
Thread-Index: AQLsRp1oNBYaHL+h2+W9Cnf47rjT4wJAtc24sSYxOUA=

Hi Felix, thanks for the info.

Is it only about mt7981 or mt7986 too?
Strange that patched code works flawlessly (or maybe firmware just =
sliently ignores scan requests?).

Lukasz Michalski

-----Original Message-----
From: Felix Fietkau <nbd@nbd.name>=20
Sent: Tuesday, February 25, 2025 9:30 PM
To: lukasz.michalski@onet.pl; linux-wireless@vger.kernel.org; =
lorenzo@kernel.org
Subject: Re: wifi: mt76: mt7915: fix broken background radar =
implementation

Hi Lukasz,

On 21.02.25 16:35, lukasz.michalski@onet.pl wrote:
> Currently enabling background radar in hostapd results in unreachable =
AP.
> There is because of mistake in enabling background radar=20
> implementation for
> mt7915 mcu driver - 3rd and 4th parameters are swapped.
> mt76_connac_mcu_rdd_cmd requires rx_sel as a fourth parameter but this =

> parameter is provided as third argument.
> Fix was tested on mt7981 and background radar works now correctly.=20
> Other
> mt76 drivers do not have similar issues.
> The issue was also described here:
> https://github.com/openwrt/mt76/issues/958
>=20
> Signed-off-by: Lukasz Michalski <lukasz.michalski@onet.pl>

MediaTek informed me that MT7981 does not actually have background radar =
detection in hardware, so this patch can't be merged.
We should instead change the driver code to refuse attempts to enable =
background radar detection on this chip.

- Felix


