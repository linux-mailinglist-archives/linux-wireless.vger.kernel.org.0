Return-Path: <linux-wireless+bounces-14435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6229AD5E5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 22:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D5283745
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 20:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBDB1E2826;
	Wed, 23 Oct 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pbx.org header.i=@pbx.org header.b="NwQCND4q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4013AA2B
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717152; cv=none; b=UzLpH9Jcw1S/lDCp0ikonm+PonE45nO80XOx/xifXMzcwGx6Ij0wOT8/GuPOJwVUu4ByaeBZPHTD23jhFKSFOukDyoJjPymI2/WES4dUnfE76pxYqfR1iIyn9gcl8Gwkcm/8XjDXeKe+FdU+a0hEoOdnk1Hgp/fHRoKAewLDs6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717152; c=relaxed/simple;
	bh=Zh9dqhZbyHShHWZ2zapGHGtq2M/73pX/MVlJU/ffC2o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VvtbEjd3QKjLgkANQgI3RZjtgzkpu8+rH99YT4+KJtWTfSU3zvSKzX2Kq4Yn6+Ge3Bk+DEFjuFtGnoZc42p5rop5FQ3YuZAstQ9wSINH/Vua70Xgze9rGbFeFvg6PCZlUB/w/v8sOv25ivlQhGPtJZbELpZydJOpYCXyf7e2xQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pbx.org; spf=pass smtp.mailfrom=pbx.org; dkim=pass (2048-bit key) header.d=pbx.org header.i=@pbx.org header.b=NwQCND4q; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pbx.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pbx.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a47f8a9168so75159137.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pbx.org; s=google; t=1729717149; x=1730321949; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zh9dqhZbyHShHWZ2zapGHGtq2M/73pX/MVlJU/ffC2o=;
        b=NwQCND4qLnk8upPV3oQxB2Mft07bDMSelliQQz+TU2MP0fb0mLNxfg6lkGxZtenKbE
         TWwXewbL4wtPk1uFn1yQORmZe5AjaFHvbcM97NJENKpYl2TB5iaGEm/lRr8eIC8kx6IS
         eHkgo7MExCPBRW508kjAmkVTXXWXqlU5PLpDOuZHhxmUIKmGUav1C1ktvKFP5CcjMDxN
         SLo7Oj5xbCOS23Yg2bPPPopiwLcVQHjaAkUoBFOd2Xd4itld6br1ewK2POiD+Q7+hncT
         IOW79MWlQlSi74sqtjEPLo8OciDhFDf1c3bgI1JxRM+vB1WYv7esOcimfTOgeibesBna
         pOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717149; x=1730321949;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zh9dqhZbyHShHWZ2zapGHGtq2M/73pX/MVlJU/ffC2o=;
        b=d9TTM46fY8vD7cU/bIcjnEmd1RtuqBQJW2DG9j6hrIfo3xG72PYGyHYB+S0J2KPlwl
         enrvcuacPvhPubZiCNcuG8xOq0Isw8+hLDDGhNf5yLPlngaLXubp5UKQpPaeWKpZmjdp
         MPKwdCO59UD2hqJLfKR13S1hKOIfOGzf/up51gt9h1Sz3ba7yFygso0TbzFnUR1TCYkQ
         RLNcvPA2Xxed6IKoCszQf0RD6Tz5fjtbhP4ZM6ukVmxhePtmU0N9QjlAvDT/EnNlFICv
         M82+EccDxWjCsghyL1j7IqmIyD6pcLRVkf3wszsxusxpMiQu1llvYVUuRwZg6xBRFY5K
         5irA==
X-Gm-Message-State: AOJu0YwxXe2pARvM8OLQJmyhXU5vowRykBk03Y2RqbzV1TsRQFS+KZm9
	XWVHrRi47JTqr+ytJ4CjWvZPjglmpMqnMDJ66tntvfepPoCXJnT7u6VNvgUzYmSBQV/Lwj0yTkN
	VMOnthPflzRO2fDjveV6TEBOXUBC43M+ULIYOn6sLN1Uy6VXBaw==
X-Google-Smtp-Source: AGHT+IGsL4ZJSdzJNd93zV9VKsKAJu/ZxEtrkryHPa6skRd8gpSX3DmuBRff6Wim/dR9xm48PSk+SsC+PnPf6m+J8QE=
X-Received: by 2002:a05:6102:d8f:b0:4a7:4900:4b7c with SMTP id
 ada2fe7eead31-4a75162f339mr5076817137.0.1729717149320; Wed, 23 Oct 2024
 13:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Kyle Cronan <john@pbx.org>
Date: Wed, 23 Oct 2024 15:58:58 -0500
Message-ID: <CAFqYJVEUjXPVARSj-dMS0=vhocu4=HSke_p4=PfGMBob6bGJHA@mail.gmail.com>
Subject: How to distinguish multi PHY devices for interface naming?
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This is not an especially serious issue, but maybe I can get to the
bottom of it. I was using the Mediatek mt76 wireless driver with one
of the newer cards that presents multiple interfaces, one for 2.4g and
one for 5g. I noticed that the usual udev setup with systemd was not
naming them in a way that makes sense: one is wlp59s0 and the other is
wlan0. So I investigated, and found that udev doesn't have access to
any information that could distinguish the two interfaces that share
the same PCI port path.

Here's the issue I opened with the Mediatek maintainer:
https://github.com/nbd168/wireless/issues/12
"Systemd assigns the first, wlp59s0, using the path-based name, but
then the second one tries to assign its name in the same manner and it
conflicts, so it has to fall back to wlan0." I took a look at the
kernel sources for this area, as best I can understand them, and made
the suggestion to set a netdev phys_port_id attribute uniquely for
each interface. That would result in wlp59s0n0 and wlp59s0n1. (There
appear to be two other possible methods, though, corresponding to 'f'
function and 'd' device port. Unfortunately I never made it that far,
trying to learn the implementation details.)

I got the response, "the driver is not responsible for managing
netdevs and their attributes - that's all handled by the mac80211
stack. What the driver does is register two ieee80211 wiphys on the
same PCIe device. There are no separate devices here, because on a PCI
level, there is no isolation at all. It really is a single device. The
wiphys operate independently from each other, so naturally the
auto-created netdevs do so as well. ... Not sure what the solution is
here."

Is this the 802.11 stack's concern, or the device drivers'? How could
udev get the info to distinguish these network interfaces, and which
approach is the right one for wireless devices?

Thanks,
John

