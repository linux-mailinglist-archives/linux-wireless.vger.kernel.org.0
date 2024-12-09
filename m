Return-Path: <linux-wireless+bounces-16014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61B19E8A66
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12F01885500
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7814F18B46C;
	Mon,  9 Dec 2024 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLe48+fd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5A189F5C
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718963; cv=none; b=CmXlxZ7ZgN0VCJCPRMDMYLqNXJ+UGVIT6M37+4kscG0JoTR/ssQ202/YibYOYzk7hKPyBw9p2xQ7Tdg+WkUwooz/g80cLG6x3jJLZ+n0U96JVlOUw6Mg7+6kOQs3j8sYS0TIp/LHjA54qPbrZkLQqhhfIaY4CFo3bbDJhghiNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718963; c=relaxed/simple;
	bh=CCYgGonU4JXnMK1tYRCbIHv7YN7XHoHlsx84CpiUUqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bdGMVw6U6AN7hsAFn2r/EtP1tXabW3kKs87EKEoO7LqCropNRAazQYpl+m8j3p7A4xJy+pl143/vTsu++OlH5gaFVVVAIakJqljQwmb0B1L/1T8LMnUwUdXUnXcNF2EAOwbDPwEt50ampOcTyesmizy0CMnCO5uobum9Y2iZD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLe48+fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBF1C4CEE1;
	Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733718962;
	bh=CCYgGonU4JXnMK1tYRCbIHv7YN7XHoHlsx84CpiUUqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VLe48+fdh8RJhpkUxHoHnBuFUhUmvviVhh390/XIQjOWTS0zygHkn1N9ArUzQyzQr
	 taB7VZHKxaCplSwk1JaAg2fMA3I/+JRieOonDer5tuUYqXimSgvWW2BGX5Usu64gDe
	 8MPPIQjblp9BVQLzm3tx0+5VP0DGHkae49l8EcEEccJglEQYlJA3ePpuppCMIEiU/J
	 Ro0+za9WIcdaGv8+w9r1kwyqLcm6s3rO9II3Tzb4ahatzUIhAtcOKASmR6d+zsH4S9
	 wrzOkNgnzD+l+rTw1XPtvhWw/SViUQBRSmjEI/ZVU/PFJ75Ob52j3CikNguznse2xa
	 eTkcf5SEkreNw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id A1F3C5FF03;
	Mon,  9 Dec 2024 12:35:59 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20241127093208.4693-1-pkshih@gmail.com>
References: <20241127093208.4693-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Azerbaijan
 (AZ) on 6GHz for 2024
Message-Id: <173371895965.3369899.11075083135519466066.b4-ty@kernel.org>
Date: Mon, 09 Dec 2024 12:35:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 27 Nov 2024 17:32:08 +0800, Ping-Ke Shih wrote:
> The ICTA established under the Ministry of Digital Development and
> Transport of the Republic of Azerbaijan announced in June-September,
> the State Commission for Radio Frequencies responded positively to 17
> applications.
> 
> At the meeting of the State Commission, taking into account the
> Decision No. (20) 01 of the Electronic Communications Committee of the
> Pan-European Conference of Postal and Telecommunications Administrations
> (ECC Decision (20) 01) and international experience, the "Conditions for
> the use of the 5945-6425 MHz radio frequency band for Wireless Access
> Systems (WAS), including Radio Local Area Networks (RLAN)" were approved.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Azerbaijan (AZ) on 6GHz for 2024
      https://git.kernel.org/wens/wireless-regdb/c/b19ab0b82968

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


