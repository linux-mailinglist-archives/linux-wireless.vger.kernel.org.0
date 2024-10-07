Return-Path: <linux-wireless+bounces-13575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58949922F5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 05:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0A91C220FC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 03:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CFE17BAF;
	Mon,  7 Oct 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY+sVTr6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA86179AA
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728271672; cv=none; b=S+43QJUpDtTtwl73aDcXK3f5YyYUMDVtRaUOm9u7y5KAKOPDi2SPuHH26029sSwmEQFbNNoVasA4tSTFl7xD5y5VOSYcRjicXyasShZNV2oOuTK4Jm9ADSiwwqdUHbNPbeQHYfZP+qTDI1BcvCn3vPb+7f3yq/WtEV9FppiRYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728271672; c=relaxed/simple;
	bh=1t/lSy4IfuXem+6A9uGXznJm0uW6jqUdtS2x6XVrMjc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XxVe8Yepk3wAyJKu0lFO6OezHrYpOpz0aTQzPt9sNuDO+uhkSxYwVyKjh01VJQSNkCETyc9D5nKOGXbvdjd5XAVb+ctTct9ZCfGCl2UUFz04HeHl84YZEjk6WXbjaCw1wjALYYbeZVIpAsIH5lR1jrsF2GwpsFUWMQPhXKM440E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY+sVTr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FE1C4CED0;
	Mon,  7 Oct 2024 03:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728271672;
	bh=1t/lSy4IfuXem+6A9uGXznJm0uW6jqUdtS2x6XVrMjc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XY+sVTr6A8PM4TLQpFe7HIOpHmRmMd839QHQIYpIfzsbnKIFlASN2xyMX4Zmpz38e
	 +qdbCl050Xd+VXQ9WWRqFRtasjSNg8WQhiWsDAX/DIYJFLLNp9fqxBaAYC6XJ2nt/E
	 tkfnn2A7M413ZS8xto6StLucl7OxKvQ2zXBKzYvXcF/0OSj9KJ/uquS5K7vjA7RnbS
	 fifAwPQbrl8oFB/gBSxTVocCoSnxJ0R6XRoChoxRdyWWV9Dy0Uhtm3/F+JRziSTAna
	 eh77CxSIIdnAqGR2U7JszVofA3cK+4hsPbtR/K9YMZsnYWPSeKXa6xiNnfhNdbpSWu
	 F1jeDWiXODHVg==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 694C45FF0D;
	Mon,  7 Oct 2024 11:27:49 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240930090347.11085-1-pkshih@gmail.com>
References: <20240930090347.11085-1-pkshih@gmail.com>
Subject: Re: [PATCH v3] wireless-regdb: Update regulatory info for Tanzania
 (TZ) for 2024
Message-Id: <172827166942.1242641.12760370003078122996.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 11:27:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 30 Sep 2024 17:03:47 +0800, Ping-Ke Shih wrote:
> United Republic of Tanzania, Tanzania Communications Regulatory Authority
> released Minimum Technical Specifications for Short Range Devices (SRDs)
> on 2024 [1].
> 
>  * 2400-2483.5 MHz
>    - 100 mW e.i.r.p.
>  * 5150-5350 MHz
>    - 200 mW mean e.i.r.p.
>      * The maximum mean e.i.r.p. density shall be limited to 10 mW/MHz
>        in any 1 MHz band.
>    - EN 301 893
>      * without TPC: 20 dBm when operating in 5250-5350 MHz
>        (20 dBm is adopted for 5250-5350 MHz)
>      * DFS: 5250-5350 MHz
>    - Restricted to indoor use.
>  * 5470-5725 MHz
>    - 250 mW e.i.r.p
>      * The maximum mean e.i.r.p. density shall be limited to 50 mW/MHz
>        in any 1 MHz band
>    - EN 301 893
>      * DFS: 5470-5725 MHz
>    - Indoor as well as outdoor use allowed.
>  * 5725-5850 MHz
>    - 1W
>    - EN 302 502
>      * DFS: 5850 - 5875 MHz
>      * FWA device shall have the capability to reduce the operating
>        mean EIRP level to a level not exceeding 24 dBm for ChS = 20 MHz
>        (24 dBm is adopted)
>  * 5945-6425 MHz
>    - 23 dBm for LPI usage
>      (should be indoor naturally)
>    - 14 dBm for VLP usage
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Tanzania (TZ) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/5097b4a2ddac

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


