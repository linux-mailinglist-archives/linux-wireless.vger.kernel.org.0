Return-Path: <linux-wireless+bounces-28033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28619BE8BD6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 15:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4823A1D9A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 13:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36973469FB;
	Fri, 17 Oct 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="u+n1vJQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECC331A5B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706312; cv=none; b=uqRRGZw0JJZpxKHh7WCOj1RuerZM6ivqY2ftR17v4IarUQVAVeRv8Zs+BJGI6RyfGxeb9vU/dUvBKGJqe5sj7VX04aPoM5gww/3bdiDKYi9hHx3InyG8MaDfXZIeUr9IigZtX3n+E3VGX1fha9SfmZdrz+PqFGtNPMm4Z5onxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706312; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZ/5ySLXO1oUB3clJze36ru3A4jCiYh9q1v/TNK9hKvJyvkCZI4OfkXh3b+POvq9+ryDt6/2zvMPsc73sBvzQP9AxlsVlneiVsS9OwKID3OkFq0dnADhAham4bIXmp4hBhzNhthvXKoQLG4Vjg3K671LYy+CVotXcmnCvqZHK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=u+n1vJQi reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id A03B5533824A
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 07:45:35 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705136; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=u+n1vJQiJW1dM6E31EvQJoEC0bnL3yE3wa7S2wGz/+5V1XOt+pgeYir9m7wTZ0yyWHq8O0
	7nGrPYjmyoJeoOTNY8heQUHTuLAnK/fpgXc/9Drf2pp9pNre3XC6E5KNdm67tKFbv8cSea
	9Kpi7VnQPj8teX0M/VdkPMFQGGzTE779j5PosiHoMBFL9Y9/Zk5uDXgSfgqknPtKSjaFij
	4ufiQzKhyUlwsSC1l2ld44cwhYjAUbuN+dy7AvxrPF3OunZECWNgdsVDLOQTepjFZPoyNW
	OtlsrUKDy0t50xVfnjF06Fk8INf7TLt4rTsWXSNb0L1OvF70qA5vRb72QUPeiw==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-wireless@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:35 -0700
Message-ID: <20251017054535.8A49EDDFA0ED9D07@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.

