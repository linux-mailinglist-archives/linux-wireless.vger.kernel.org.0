Return-Path: <linux-wireless+bounces-996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4D818AB7
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E34B289A3A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D261C6B4;
	Tue, 19 Dec 2023 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOjN9IfW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A091C6B9
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 14:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E530CC433C8;
	Tue, 19 Dec 2023 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702997985;
	bh=iGLWh6kLA3yJXp+a/UvsRQxTk2tXFCAZ3IFWN74UA9o=;
	h=From:To:Cc:Subject:Date:From;
	b=GOjN9IfWmj94F9R7UYkUBj+DtFzLGztAXVZjVU0YfDL0As4bl4VCcKLEF0r8yMsyK
	 UiPOSf7UfpJS+I4q+s7e83gWB4F2TTbdxAHUS/UlevIGetgrx9RwDYxKOeGFcbNL91
	 Os8E1fNjMizhypvizceXBJT8qFuLVYKTSfiC5wkpbRZwx0k73eNvw5GmmVvylqvHGu
	 TyIh4OlZmL8Mfet1BqzVLo+szUAcKHwhMiirfOCKelKsxj3RHI9/tUFvQ49cEijEMo
	 l6EtU/xh/6oP0xY9SOFDf4mlLGWDgA0YeF+q8LIh83dyXFdtWfDytBn1DSep1MUUwr
	 WkfQRVZKMcirg==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
    Jakub Kicinski <kuba@kernel.org>,
    David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Kalle taking a two week break 
Date: Tue, 19 Dec 2023 16:59:42 +0200
Message-ID: <87msu6qlup.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi everyone,

Starting from Friday December 22nd I will be offline for two weeks. If
the weather is bad (read: not cold enough) I might sporadically do some
upstream work but don't expect on it.

Our plan is to submit a wireless-next pull request on Friday so if
there's something you definitely want to have in v6.8 send it now.

I will be back on Monday January 8th.

Kalle

