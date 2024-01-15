Return-Path: <linux-wireless+bounces-1904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7244482D340
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1871C20A85
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351F23C5;
	Mon, 15 Jan 2024 03:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+SiE0bO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B723BE
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321EEC43390;
	Mon, 15 Jan 2024 03:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705288474;
	bh=6XKzR6JpKzRVxLCrT4WttGuLf3DaR7RKYdWUPZ3p29E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c+SiE0bOIZ61YUIPVID7IGhSjgB7/OzKdiY4JTGdkrEukqQBABVHn/6YcxJyCyTpl
	 jzDFxGBBNWbheOccbhBGZfNqrgECgVXgDFpWjc9XP07ie93MuPBj5aZ1nhQRYC9wSA
	 LV5qAmCJ+fvqvaVRVheJZkJ/GLs9roTRR/uugD0BCwWhn7sKuBBl0kgxWUWbq9qNEL
	 7ZSy7xhKYrnEJB/yGEFHDvp+3X4r7dwM0REdO6k/WaQNBqA2lhncByhm1MD4XZUDq4
	 8GtmbUEbQjXFsldGosy6RMTiqX0R1kF2+5lI+wbU4EpXeUZPHSVM2zK8QEBlQgQw1z
	 lTP0WShOrZdKQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 0D39F5FCA8;
	Mon, 15 Jan 2024 11:14:32 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Andrew Yong <me@ndoo.sg>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20240112040217.24356-1-me@ndoo.sg>
References: <20240112040217.24356-1-me@ndoo.sg>
Subject: Re: [PATCH] wireless-regdb: Update and disable 5470-5730MHz band
 according to TPC requirement for Singapore (SG)
Message-Id: <170528847205.770636.8573617454652565233.b4-ty@kernel.org>
Date: Mon, 15 Jan 2024 11:14:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 12 Jan 2024 12:02:17 +0800, Andrew Yong wrote:
>   - Use original regulation Tx power of 1000mW with TPC for 5470-5730MHz band instead of -3dBm offset without TPC
>   - Comment out 5470 - 5730 band to disable it since TPC is not implemented
> 
> 

Applied, thanks!

[1/1] wireless-regdb: Update and disable 5470-5730MHz band according to TPC requirement for Singapore (SG)
      commit: d695bf21d1cdf02e64924f452c242f7588469609

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


