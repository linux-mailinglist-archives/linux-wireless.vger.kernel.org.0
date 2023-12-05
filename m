Return-Path: <linux-wireless+bounces-419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B868053CD
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713F41F207CE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D91259E4D;
	Tue,  5 Dec 2023 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeIL0PFp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C756770
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 12:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBA3C433C7;
	Tue,  5 Dec 2023 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701778049;
	bh=lnKGDBAxB8eBxYMZ/Jm5VaF2xsTMrWs6Ne8f9Aw7vjQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FeIL0PFp9XGF5OiflZcnKBgpJ//p36iYTkX/bRoAle2kHEzcDvrUZCHdpOhhr5D3+
	 ldQAE4WtTVYfd2PGV9YOfKswfZdtnGpHsYGbfYEpvQkfw1/7IwUHsyp8sRAaXQrA8Q
	 UojGTHrerdAC6owGBFQpmABMzdXyZGpsmi7pK7D+pLMsJgEsniRpmd81ake4f5uQla
	 dkx9nvEIUp3QCzUtueyQoPwEGW+owYCBivuQkRGbdUyI6CZ4egK7S1zogzSe1pdqVg
	 QYIgrreNVZhXj2Yjhc7l9YUU2NEs6EnPjviUhmL8wih+v4NtgFP+qA541saOL87hXd
	 w7IkezvhTO8mg==
From: Kalle Valo <kvalo@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,  Felix
 Fietkau <nbd@openwrt.org>,  Nick Kossifidis <mickflemm@gmail.com>,  Luis
 Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] ath5k: remove unused ath5k_eeprom_info::ee_antenna
References: <20231205111515.21470-1-jirislaby@kernel.org>
Date: Tue, 05 Dec 2023 14:07:25 +0200
In-Reply-To: <20231205111515.21470-1-jirislaby@kernel.org> (Jiri Slaby's
	message of "Tue, 5 Dec 2023 12:15:15 +0100")
Message-ID: <874jgwrgxu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jiri Slaby (SUSE)" <jirislaby@kernel.org> writes:

> clang-struct [1] found that ee_antenna in struct ath5k_eeprom_info is
> unused. The commit 1048643ea94d ("ath5k: Clean up eeprom
> parsing and add missing calibration data") added it, but did not use it
> in any way. Neither, there is a later user.
>
> So remove that unused member.
>
> [1] https://github.com/jirislaby/clang-struct

clang-struct looks really nice, especially if it can also find unused
structures. What about unused defines or enums, any chance to find those
in the future? :)


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

