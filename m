Return-Path: <linux-wireless+bounces-12524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5C96CFC6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 08:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72400B2111C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394418BC24;
	Thu,  5 Sep 2024 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="egRCfIG/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C9189F30
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519104; cv=none; b=KEyWeS9u+RBIYzqj/999PwyYdEbrHgMnqK+toZ6D+hEAyAkO0lVnefTgGHIa/aoGgBh3/GX529hMyIQAlQx1PFsf1Gz0KPAPxOb4/8PGMVbduRHLOvPYMj7VGQ2XDn31g7bG3t68Xtoje24jVaedjZGsR0nt8UZgyHdN2DMBAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519104; c=relaxed/simple;
	bh=SPEXJ11irYRAyq6tL80mDE86hNqcdZC9xTUPXWo2ksI=;
	h=From:To:Cc:Subject:Date:Message-Id:References:In-Reply-To:
	 Mime-Version:Content-Type; b=ahdhqkjt47+Ngnn5G2G5LvX4mimTp5yY0xO4EGEvOIUOlJ9VvxWFb1mnWmirnnZ40NAGzXKcCeYFIRglDe5EacSwNwkqg2JmCFoqQuKaECTwflOzU6HdLP7Vh8bM5KN1VBNyjIOliZ5OZ3lehI7fVKUDGWfwfefXQOvPMbM+HkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=egRCfIG/; arc=none smtp.client-ip=77.75.78.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxe-85b96b7dcc-v4qq7
	(smtpc-mxe-85b96b7dcc-v4qq7 [2a02:598:128:8a00::1000:aa2])
	id 65a92bf99b5d99536527a5e1;
	Thu, 05 Sep 2024 08:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1725519082;
	bh=8xXH12nHQz7aEzM4VNnK8tIHRlyWLQsZTm3oQymSIk0=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:References:
	 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
	 Content-Transfer-Encoding;
	b=egRCfIG/ie+S3drdGOWJmP3gzh30oOo6oKpwiJJHCmgMzBhhCJwVp5eeNzPbV6R6+
	 yV2w48S5PNgogrmD8WDM3vZTlghGGMJQpCj2F/19o6oZRSTQMIafQvJ5lh1VkRyivZ
	 S4WIxYRRNdFOzuDoLKwZEKNCSqBlrZls2Y/GgeAgfCYJ1XtBpQ1NSYlK+svxmun764
	 7I/2EEafhXJN8sHfBnVb3ulSdQq9w+qwzTiStWWlWhKq8JsfQbG43+2K5wVEvM5fMd
	 p9WHNTFbOsu5lmLpMjHyV1YHGZ+SLblc6mX7/0kgJcXnvDIUhwbVAUMbJkKOS5WodP
	 08/1gYp6I8g4Q==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Thu, 05 Sep 2024 08:51:21 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>,
	<ath10k@lists.infradead.org>
Subject: Re: [PATCH] wifi: ath10k: add USB device ID for Atheros QCA9377-7
Date: Thu, 05 Sep 2024 08:51:20 +0200 (CEST)
Message-Id: <5J1.Zbdp.2t{MJKBvQ7h.1csLJe@seznam.cz>
References: <22t.ZbsX.5bWREDtSGGB.1cqQpF@seznam.cz>
	<8b7d9777-e239-4173-bec5-607e15b98130@quicinc.com>
	<56o.Zbc9.7x3xmPitckT.1csARP@seznam.cz>
	<c9f1100c-b34a-4d77-bfbe-1e20cf4143ef@quicinc.com>
In-Reply-To: <c9f1100c-b34a-4d77-bfbe-1e20cf4143ef@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Ah, my good friend qcacld-2.0.
>
> I'd expect to see something written to kmsg, but not sure it is there fo=
r USB.
>
> for QMI there is: 
> 		ath10k_info(ar, "qmi fw_version 0x%x fw_build_timestamp %s fw_build_id=
 %s",
> 			    qmi->fw_version, qmi->fw_build_timestamp, qmi->fw_build_id);

> but looking at past ath10k USB changes I only see:
>     Tested-on: QCA9377 hw1.0 USB 1.0.0.299

> So I guess what you have is OK since this just allows you to be probed a=
nyway
> so that is actually independent of firmware version.

I cross-compiled the qcacld-2.0 driver and it printed this:

Host SW:4.5.25.50, FW:0.0.0.111, HW:QCA93x7_REV1_1

It looks like that 8devices is using their own firmware numbering.

