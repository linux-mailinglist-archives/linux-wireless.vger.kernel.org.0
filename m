Return-Path: <linux-wireless+bounces-24793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0BAF77C8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 16:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F0B17C8CA
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D16C2EE272;
	Thu,  3 Jul 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqhKE1Ez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C72ED86F
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553590; cv=none; b=hT+cxoXA3gMsEMA1rIQH02gSwC+M/g+ZnefDq4HV5ynlrOck398mi5XrbYeT6Db9Qd4kzWq58Svhn4Rl+H/b29dUlfi03At+rE6qjaXILZm5E9Zzv1sWV3bQY6WxMW01kU9Bs6yT+9OSlkx9zEbtTTX+fgZPL1OyjWGRbnpz1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553590; c=relaxed/simple;
	bh=rqvzcOGtggHK1HdqCLGJDxgHLdc+gHMLK7oTthIT6G4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SCmsFEY7lRYJK1skB4bpq+Wyc/XTvzsFRx6VA+fwa+pQ1/6eEjPt4oTIAJtyqKjuW4jQpGmblvX9CL4bNhesDKdueapWLzoyEaOOM51U5QE+gyhH1OXx22BBDy2flskKQSLqU/L2TOIEtqTPJxOV/hiGFUkdmvtIXZgw4vc9DZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqhKE1Ez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C10C4CEE3;
	Thu,  3 Jul 2025 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751553589;
	bh=rqvzcOGtggHK1HdqCLGJDxgHLdc+gHMLK7oTthIT6G4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LqhKE1Ezc7rDWASL+peDD6y4moi+ogM1FhIA60MeMvKsqsLzmKTQzNerLswmMYuwZ
	 m71OrgJFClJx3Ihv0DP71dSKnqU0AcwdvIWEpmN7ulM2t/hd4GKR7n8SRv5hcDJSum
	 DMz9LRrHJLQvSi2IKeZaB57jGUp6yPXbr2EN/eZOyFMUb1Sn7yDH/i6KzU7BUG/FYi
	 IJOxlUZb4U6sSY3TJd+k6wPJJAgspp4yM2fw7dUc52BMXABYmGXb9aqvrUbdt4BJcq
	 yvjgtLoofKbGVknthkIoA74NFicTJntTPxD8OjraU7yx9IXkhzpm9pzbPKF+SCOvNP
	 JfsMgjGotTlLw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 249725FB0F;
	Thu,  3 Jul 2025 22:39:46 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: =?utf-8?q?Taavi_Eom=C3=A4e?= <taaviw@aegrel.ee>
Cc: wireless-regdb <wireless-regdb@lists.infradead.org>, 
 linux-wireless <linux-wireless@vger.kernel.org>
In-Reply-To: <c6eb2f23-f15a-4a4f-9934-f8d524bc2cd1@aegrel.ee>
References: <c6eb2f23-f15a-4a4f-9934-f8d524bc2cd1@aegrel.ee>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Estonia
 (EE) for 2024
Message-Id: <175155358607.1087851.15293340917846249231.b4-ty@kernel.org>
Date: Thu, 03 Jul 2025 22:39:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Mon, 24 Mar 2025 01:55:05 +0200, Taavi Eomäe wrote:
> Allow S1G operation based on currently applicable usage rules specified
> in annex 6 of "Raadiosageduste kasutamise tingimused ja tehnilised nõuded
> sagedusloast vabastatud raadioseadmetele"
> 
> Enable AUTO-BW for all 5GHz bands as no bandwidth limit is specified for
> these bands.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Estonia (EE) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/490f136d0b42

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


