Return-Path: <linux-wireless+bounces-30037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C6CD4644
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Dec 2025 23:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905B930053FB
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Dec 2025 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB008248F62;
	Sun, 21 Dec 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4CjE9BR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C08800
	for <linux-wireless@vger.kernel.org>; Sun, 21 Dec 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766355958; cv=none; b=cAyUsTlfOpTp925ngGm2pMHh3G5BrAvzcQ/KWKLO77R7m5hqmEMQzuNeH9NCvJ8QTgYzvfCqBbNABXBruegmR9tQ2ljHWXlyr6eG9PEdbHBuZsuB6dtmGnnjWxxrK1thjIrDqq9ZHnHb400AJnqw7mE+xYKSr5nxd+sVrkx+wC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766355958; c=relaxed/simple;
	bh=VLOELWUhBKZ/zTU6+PAgBTJpfTf8I4h9nzOSRFWhYW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ICW6WcEp5UVJOsPQW3+cqz0iETCZzYqbkRb025BQELyuE09AApDkRPeA7GmWQI7g86GkX9qDBaEzqg9SRA5T4wQzlqfha3EM3ueP0bRoFc58kbm9rKltjNbQlgTg8+ADtsJK+XvEKdY9HETgdGAl7M1OgjHnK7tf2Hj/tPYCm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4CjE9BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DE9C4CEFB;
	Sun, 21 Dec 2025 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766355958;
	bh=VLOELWUhBKZ/zTU6+PAgBTJpfTf8I4h9nzOSRFWhYW8=;
	h=Date:From:To:Cc:Subject:From;
	b=s4CjE9BRzHrULoTZIxLK1BR4/fP62u0XCmWYL5L06xf1JsW+MOJdbzDPxPO2LZXAG
	 uLwjGAEGGchDL2m2/FbC/0+7YvpodhCpiB4egz2lL6t7KV89tZ6jtiWPtGrrPuua1B
	 FSlMCngN/STepDwN3yU8FA/NppGmOC2eMBxFQEMdN+INIj/6e4NjBX66SUuaKvVoqW
	 lT9fQwlBoj0Q4ZxiRYc/7zQH+7gjUnRm/MAXqLx11BSCkKa0miqwmA/BNX3dSUTqDo
	 zoOkLiZyEvg3jc/lDzrGEYpf9m5dSuGWsRfC8Neto7bjn/e5T8sKO+8nFwE4qAhQzH
	 TVXFHwr+AKNMA==
Date: Sun, 21 Dec 2025 23:25:54 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, "John W. Linville" <linville@tuxdriver.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

This only worked by chance, because all callers of this macro used the
same identifiers that were expected by the macro.

	$ grep -rn ath_for_each_chanctx
	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, ctx)
	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, ctx) {
	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc, ctx) {
	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc, ctx) {
	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc, ctx) {
	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, ctx) {
	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanctx(_sc, _ctx)                               \

Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating channel context")
Cc: Rajkumar Manoharan <rmanohar@qti.qualcomm.com>
Cc: John W. Linville <linville@tuxdriver.com>
Cc: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi!

I haven't build-tested the patch.  It should obviously work, but please
check.  I just realized about it while doing something else, and thought
I should send a quick fix.

Have a lovely night!
Alex


 drivers/net/wireless/ath/ath9k/ath9k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 6e38aa7351e3..e8635bf81f9d 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -443,7 +443,7 @@ ath_node_to_tid(struct ath_node *an, u8 tidno)
 
 #define case_rtn_string(val) case val: return #val
 
-#define ath_for_each_chanctx(_sc, _ctx)                             \
+#define ath_for_each_chanctx(sc, ctx)                               \
 	for (ctx = &sc->chanctx[0];                                 \
 	     ctx <= &sc->chanctx[ARRAY_SIZE(sc->chanctx) - 1];      \
 	     ctx++)

Range-diff against v0:
-:  ------------ > 1:  6ab107cf786f wifi: ath9k: Fix typo
-- 
2.51.0


