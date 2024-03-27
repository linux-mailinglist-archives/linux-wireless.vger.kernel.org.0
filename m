Return-Path: <linux-wireless+bounces-5350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60AD88E5F1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C32A29E66A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9C41757;
	Wed, 27 Mar 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lONlhKnk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5E12A171
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544026; cv=none; b=OzVMpyQAx6JECfFaOwqF+UKuNqf3Jq59FsvEKWEiuoMduI00u+1BEa9o6zpch4mZItVhV2JHapNY1AWOlnRXISHLPCiEm1ovGeMBJIAK5Si1Hhpa940b6jHGo0Dl338yV2eMaErnfInCVNsypVvPilVaPzOq0qGuhgGoAAExF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544026; c=relaxed/simple;
	bh=D7ySzSKFyti1KATa654us7jWP/1eYd/sw70xVw/Wwc8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VmbCv1kGMUqED7+TYh5pbWDLIekno0DdPdTXAIljMVsWu16QZEUmnytN5RqklDJ6Gx+US1nNp5b6yQkETjV9rSJWKBMjeV8t1royodGbG1Vc4Too+dZykSPaqS3NrSddMn6QgPUy4HypZzg+ur5iX+60/n/6APYBB0tOxRLHeNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lONlhKnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1566EC433C7;
	Wed, 27 Mar 2024 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711544026;
	bh=D7ySzSKFyti1KATa654us7jWP/1eYd/sw70xVw/Wwc8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lONlhKnkpDdURqlm0KaVNAQWr+WrkTbbQVmrPwTnDun8BOK56s7Ov+/UmJ3iDayV6
	 ii1E0DBAAWpFIm3MalYfKOMgVUlBNUmIswTjAcpcB7eXDYpFs36JSDMaqnqFdQbme+
	 5GhR4Pb9n1iLS3ap0p4LdTe7fLPkae3HjQTcK8db98pQjhbSKL+G1Tj/Jy0MF1w+4J
	 ODBpavhVmIFr9PJvFt1bK9FAFn7Fg2yKHFK9fhIN1Nz3fVDMbG12hqPCkQqiw6ZPhU
	 Gbz66O1wPqnH84aUuX47OAwESELZs7ycVzUktjYcX9e40lR7Hdf78Gel1kBkd2BLf2
	 shsC91ZJySzQA==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "Larry.Finger@lwfinger.net"
 <Larry.Finger@lwfinger.net>,  "s.l-h@gmx.de" <s.l-h@gmx.de>,
  "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	<ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
	<5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
	<8a90f3cb-7218-4f23-8aa7-fcc68e2f4a93@gmail.com>
	<87y1a4yqvh.fsf@kernel.org>
	<5d117cf09134b034e704b8a1b5167235963a9c88.camel@realtek.com>
	<de1af6c3-25e2-4480-9da3-f3e5de1d6d5f@gmail.com>
Date: Wed, 27 Mar 2024 14:53:43 +0200
In-Reply-To: <de1af6c3-25e2-4480-9da3-f3e5de1d6d5f@gmail.com> (Bitterblue
	Smith's message of "Wed, 27 Mar 2024 14:36:06 +0200")
Message-ID: <87ttkr7s4o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> Only phy.c includes table.h, so nothing would be duplicated.

You mean _at the moment_ nothing would be duplicated, but once another
file includes the header file it will be duplicated.

Anyway, Linus has said that static variables don't belong to a header
file and I agree with him.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

