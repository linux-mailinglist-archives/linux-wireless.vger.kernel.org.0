Return-Path: <linux-wireless+bounces-29451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1CC98BA4
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2BE3A33A4
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FB2135AD;
	Mon,  1 Dec 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqCjxBEA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FDADF72;
	Mon,  1 Dec 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614131; cv=none; b=c+J1NtPAVNIfLgQWekpmd7jHfgxBYwlbxG7jT0tzUavURsG4fFZ5FlHL+9ZcqNbarDZtjCNTleayNAxQL9hzaMdirMBakK/79kQbnO1EJHYKREpw3RVPqDiSzfkFDnRaqVhFV4CFvNYQ8JFucX76txYkqIr6uhHNxk9AUg40mGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614131; c=relaxed/simple;
	bh=VBQFlvnfpbsIVYd7kucDkAsZ9TrCBZTzgqxZRRFJ9xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIrXd2phhGC7uOZ1QWWgQuHlF6u6oG3JmqSQ4Nf29RbAFp2+0O+pBbG81GEYrjqkx3OZcaE840xkj+fk5gUrHM1LwRTJiv4C4MyGdsXNEeczFlofxYU44yc1TKOdSioyhjoG5M7eLfj/OxoqRY2MTHPOy/iOTKHBcl63chXsBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqCjxBEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83049C4CEF1;
	Mon,  1 Dec 2025 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764614130;
	bh=VBQFlvnfpbsIVYd7kucDkAsZ9TrCBZTzgqxZRRFJ9xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqCjxBEAx9GYCBJaYTNiYd64kKa8S/v0nyYaM47cIxx6x5dS2qxta4cb8ccKFlfK+
	 bbElowOjQLNB8S2ZZY5VeXmGtSXKqKSRTRXiwgcldQKpO0PQA0Y4Vz/nlMslQAeGEN
	 lwGwBiFxiix6kslLsoZ1RS9uljoGAWFAxTi/gw3miJqV+gKMuftxGEiC0La86z1hLS
	 7uYxZsFC7PkbjHlXjHMi5SC9kExUk+0XZY5B36ZdK4LhcH6TYHUg04UB97OAU7FUoF
	 SfSclH0QhROBkzGB3fibk7fQ8WkUMvUHqK0IjXEfKGjC2VBOtHrJFE22niJALHKnQM
	 7WedwgfcoYqMg==
Date: Mon, 1 Dec 2025 10:35:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] wifi: mt7601u: check multiple firmware paths
Message-ID: <20251201103529.1874a869@kernel.org>
In-Reply-To: <20251201090336.1157193-1-christianshewitt@gmail.com>
References: <20251201090336.1157193-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 09:03:36 +0000 Christian Hewitt wrote:
> The linux-firmware repo moved mt7601u.bin from the root folder to
> the mediatek sub-folder some time ago, but not all distros create
> symlinks to the old location the driver checks. Update the driver
> to check for firmware in both old and new locations.

IDK.. 2.5 years ago.. how long is too long to wait for the distros 
to update their linux-firmware?

