Return-Path: <linux-wireless+bounces-7860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ADC8CA713
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 05:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEBF2828FC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 03:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359041C69C;
	Tue, 21 May 2024 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NLt5G5QR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9201134B1
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262336; cv=none; b=Qhfon83TjJSRtYS7ceSr8GkXTau59bJM9m9pXcDGApdgcUzEpl9PlEcG6Qe7cc05s4mdDvolJ+vKKfTxvdqEdHzv3Gqr4n1fF85gBc/zbFwLI8nfWJyKc3BAIVSDPQVnRsL8Qwjs3DkF3ylsA5EkvgBDO7sVQs0/9/kl0Rq9C5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262336; c=relaxed/simple;
	bh=YKEbmBP1wgKktV6kj5Cy99tFOdp/eevqUBNQ87xfV+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sPPBDoP9zjAJFXd5RoTBHAskeuvhhwq/vVPgnm7rFjgLNnUk/VDE26KGPTbLmP+7n8wu1oOCKsxWqKC55Dsd8TsuAqlsrPSBByqnTxepCUgMCM9jW86fa4hhfgcXK+iy12UaLq1/sNCkg4pDzgUwSkwauPbgFtbvtLqDOXpFal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NLt5G5QR; arc=none smtp.client-ip=17.57.155.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1716262333;
	bh=YKEbmBP1wgKktV6kj5Cy99tFOdp/eevqUBNQ87xfV+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NLt5G5QRuv0WdV1huK4kdKHrTnqSf5oHpdGtA+bpnEdWnOILQpYHh/IOpWMfY0PlA
	 mYgSJaz9ywsjADInaVZzVWv09HsNrjuYjXjCJk6mkreTnH7Yuo8w4/r1lACcBXCXxr
	 yYTREucFHwkfj9MP2yAy3t6f1fDRw7OxWvjVkKeYdlYt3UCtB6ecCubGmALNayPEpW
	 8CQwESB6RbhrB5pL830fJjVYIXmfNe8Io+8CEN1M4Q3NipEMCg5DUAk5f0T7ZTWU//
	 5giZCWAuieINtzwL2Qgg8jTi+rCxt03FgHxjrS16A8Z4otZhO/l9cil6ag3Nqr8AUz
	 mRGew7cPD4zgg==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id 5456761800C1
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 03:32:13 +0000 (UTC)
From: Andrew Wong <wongandj@icloud.com>
To: linux-wireless@vger.kernel.org
Subject: BCM43602 (Macbook Pro 12,1 WiFi Card) Missing Firmware
Date: Mon, 20 May 2024 23:32:11 -0400
Message-ID: <87r0dvsuv8.fsf@icloud.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: tjXgJlA6mszQqqczXSUOmqP7c0DeD3XF
X-Proofpoint-ORIG-GUID: tjXgJlA6mszQqqczXSUOmqP7c0DeD3XF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_02,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=276 clxscore=1011 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405210027

Recently, I've been trying to find a solution to some issues we=E2=80=99ve =
been
having installing linux on the MBP 12,1 (Retina, Early 2015). I've found
past messages on this list as well as on bug trackers and forums across
the internet[1], and found consistently the cause of the issue to be
some missing firmware configuration files. In one bugzilla thread, there
was even a homebrewed version of the file made[2].

I ask, why has this solution not been implemented yet? Currently, I find
that while the card allows scanning and detection of WiFi networks
easily, all attempts at authenticating to actually connect fail. Is the
missing file the correct solution or is there some deeper obstruction?

[1]
https://lore.kernel.org/linux-wireless/907921df-34c1-6f08-1ece-bac896031397=
@jax.org/
(and all enclosed links; covers most of what I=E2=80=99ve browsed)
https://lore.kernel.org/linux-wireless/1582685.24dAe2tvLm@buzzard/
[2]
https://bugzilla.kernel.org/show_bug.cgi?id=3D193121

