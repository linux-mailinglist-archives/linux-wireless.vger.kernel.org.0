Return-Path: <linux-wireless+bounces-12891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15217979F9A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D7F1C21EDF
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2413C67C;
	Mon, 16 Sep 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qEbuHz08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qYhd9qEU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qEbuHz08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qYhd9qEU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9B14A4D6
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483437; cv=none; b=hsfWdcx0CgemiwnQ2BahWo9FtvS2qKeBk4IhP05g8HbxrXqjIFuWyieqoRp2vLnAw108wNXRNaPBaGhJrvwUpD+iSk/4HhULqcLwqHFeOXFzGLEbQxmomq8gqSPMP9HVn1xzHEX1ujvCTsr2ONB4Z6hnq5t/X856OB4hcUC9Ma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483437; c=relaxed/simple;
	bh=OTJapcO3POfDBlQ38IrATYyBovRijWEIGyWaTlfZ4Ow=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=Pbwbkg24yXje5W81lAwLxq2ily1m6eMwROsifP0IVed1yUh6DImGney9ZlcZugrSPRqYnJ5XxMz/5eE83zxxfn8fNkA5kxlSgs5Z6G93tk6Bz13YIHmI3xaZDx2ao8sukvlmblStM3Y97H3ITwFjjFG2W6y3aI92H4YFB37nPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qEbuHz08; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qYhd9qEU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qEbuHz08; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qYhd9qEU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9808C1F895;
	Mon, 16 Sep 2024 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726483434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=JCYpXAKohfIlW3x6QjmlkJ2Le5WznREgzJLuUnIdmt8=;
	b=qEbuHz08WICnDRPYfdNIEtbgBqM5KQuM1/4JA214AlkuohasfHymoAIrP1NLKdiMGdq0JB
	AE+DRwKbdjqlisOVCIh4SYfZOBJ7SK+3snGXePyVNd07COgi4jSuk/u5h6NUkPgiVB+UDC
	4ac14rJkxpUuPU1qRI90v9xUes2O1Pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726483434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=JCYpXAKohfIlW3x6QjmlkJ2Le5WznREgzJLuUnIdmt8=;
	b=qYhd9qEUa9VfmxA1TTvCExzRiTmd643voSZMrWvvHXNj1M8Xrc1X6N1zZFQ/w6QC3Opd8z
	RUnxZLaEOzJGmiCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726483434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=JCYpXAKohfIlW3x6QjmlkJ2Le5WznREgzJLuUnIdmt8=;
	b=qEbuHz08WICnDRPYfdNIEtbgBqM5KQuM1/4JA214AlkuohasfHymoAIrP1NLKdiMGdq0JB
	AE+DRwKbdjqlisOVCIh4SYfZOBJ7SK+3snGXePyVNd07COgi4jSuk/u5h6NUkPgiVB+UDC
	4ac14rJkxpUuPU1qRI90v9xUes2O1Pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726483434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=JCYpXAKohfIlW3x6QjmlkJ2Le5WznREgzJLuUnIdmt8=;
	b=qYhd9qEUa9VfmxA1TTvCExzRiTmd643voSZMrWvvHXNj1M8Xrc1X6N1zZFQ/w6QC3Opd8z
	RUnxZLaEOzJGmiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74C89139CE;
	Mon, 16 Sep 2024 10:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uKsCG+oL6GbpaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Sep 2024 10:43:54 +0000
Date: Mon, 16 Sep 2024 12:44:44 +0200
Message-ID: <87bk0nc1yb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kalle Valo <kvalo@qca.qualcomm.com>
Cc: ath12k@lists.infradead.org,
    linux-wireless@vger.kernel.org
Subject: ath12k firmware regression with update 82318c966fd1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Hi,

it seems that the recent update of ath12k WCN7850 board-2.bin update
broke WiFi on Lenovo Thinkpad 14 Gen 5 AMD.  Reverting to the older
firmware seems fixing the issue.

The report for openSUSE Tumbleweed is found at
  https://bugzilla.suse.com/show_bug.cgi?id=1230596
and for Arch
  https://bbs.archlinux.org/viewtopic.php?id=299286

Let me know if it's already handled in Qualcomm and the fix is
expected shortly.  Otherwise I'll try to revert the change locally for
TW as a temporary solution.


thanks,

Takashi

