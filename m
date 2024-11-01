Return-Path: <linux-wireless+bounces-14812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4B09B92ED
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E84C1C20D65
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87431A2642;
	Fri,  1 Nov 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5qnxZZm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8721A2574;
	Fri,  1 Nov 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470441; cv=none; b=s7dmYfE4zNjMcaSFAY7fzyY5jqzFTPnigakV7/8qYELe13zDme+/vuL/QABeCfvB56smJXCOpZHkuRx4jyGccWkJ/jTT7/tCTyTBIIyATeRelBO7npnZAKhntKNovNZJNk3eH68vNO90Nw6wtOMiYntKyS7kJFLlhlFToEKixUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470441; c=relaxed/simple;
	bh=MrzDL65bJQbJfFRy4NHt16Xt8c12RZxptBkZmEUL1HI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=M5dfKzb7HE06vB1s2aueEYjI17KNW7hzOTiy9kWfJtGOfdZbJKpYyfyTP6T+ffCXTI6YHdSqqCN/fq/UGl+RzArOc75BBpZlUTiRmWMReNY4XxsK0LmRHYpx0DWgzIZlHpYEyRhzg1/afkoWgyrxdo6A4eCmZX7pnlwRoxtZgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5qnxZZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36118C4CECD;
	Fri,  1 Nov 2024 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730470441;
	bh=MrzDL65bJQbJfFRy4NHt16Xt8c12RZxptBkZmEUL1HI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=O5qnxZZmNRbFufGelkntIOlcyF1uwolYeTooyPv4tOeO1YIDVoujQhfeC7jhptXu1
	 PlC+D7soCbT5+/lCmHW7ZVfcOjj2EvJOhf1q1b7vXbL4dJkpHKsLKsIWRn8589C0ea
	 SMvEs1F2t+4FCJrI6NCftTdJ+tWUJAEAmEyCdnWr7+3WiiQ25U6PFoSXbWAum8Cvkx
	 qpaAFK/AtZm7hvc55OtdEOPpIle3ls0hgmXnO0mZv0ZstkkZdAaNRkfe7R0S26qVVI
	 cV6eLQZXT1AycDza25M7EQpD/vBaebDkc6uDJJ/RnCbWORzYK5gnTkrsIw7wMkuk6q
	 0/OuVAGc2iaDw==
From: Kalle Valo <kvalo@kernel.org>
To: Gan Jie <ganjie182@gmail.com>
Cc: linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  trivial@kernel.org,  ganjie163@hust.edu.cn
Subject: Re: [PATCH] Driver:net:wireless: Fix typo 'adderss'
References: <20241101074626.961-1-ganjie182@gmail.com>
Date: Fri, 01 Nov 2024 16:13:58 +0200
In-Reply-To: <20241101074626.961-1-ganjie182@gmail.com> (Gan Jie's message of
	"Fri, 1 Nov 2024 15:46:25 +0800")
Message-ID: <87bjyz6nyx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gan Jie <ganjie182@gmail.com> writes:

> Fix typo 'adderss' to 'address'.
>
> Signed-off-by: Gan Jie <ganjie182@gmail.com>

Subject is wrong, please read the documentation below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

