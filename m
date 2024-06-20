Return-Path: <linux-wireless+bounces-9300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CBE910323
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A313289005
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5E51ABCD6;
	Thu, 20 Jun 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="14nK58Dc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1b/bJhC3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="14nK58Dc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1b/bJhC3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836351ABCD5;
	Thu, 20 Jun 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883432; cv=none; b=dwWlZNtxOVIdoRAQwnaKbL+qOGgBNVgDAXXDMxDqqv092WzqNTSGlr9KqH6VqsCQPM1zUHjdO9UWkKzxYfyh//PmsuvOMWRUeC5GzsPGedsrB/3lyx5YtU0E1n17nCBe9frLjczMpajD8n6XUlqklDhddSI5yuCm6mRV6hHGKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883432; c=relaxed/simple;
	bh=jGu20gAF7CVuGmTD3FC5+rgDSogPocUptiVpPZOUnZQ=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=msO4qoDaNWpQBzLn+SJLIes8m8znnum3xXU3cF40oX5d/I7+z1cOHl1GHETuwP+jXIHcG1L6hknd0vM1/p6t6Gj1Ni6rCCCSfS9wj+ZHvxq7y5YrPYgPlmeADfhdqmaUohMZG733MFA8JhqQC37CaW+KSAFwlikOHmRTZqRilX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=14nK58Dc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1b/bJhC3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=14nK58Dc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1b/bJhC3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9D8821A23;
	Thu, 20 Jun 2024 11:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718883428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/PL53pjBrqHeHwdxri5JISd0hWvB74/wdvPY89yZtbU=;
	b=14nK58DcS52PyYysrVHnNADsg45JDGVu3h7e74FVWAZguvSTDP22yu3INbdyXn8jawTrRn
	DTDgLkYVbBZu8Kj/aeaNqcUtA8q3tqEeFKEbS+Ja7W/W8KaYBC+I3ReStG29rWUra1H4cQ
	0szW2PIK6oJ9hItgSLVA2SXW7eAFCWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718883428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/PL53pjBrqHeHwdxri5JISd0hWvB74/wdvPY89yZtbU=;
	b=1b/bJhC32so/AH8uCWjJBf6ypXXVUAw5u2kc712C60Nrup7Cp+7XM31Y31ac0aDGh7JBtc
	rxbVmlJWpEj2PsAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718883428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/PL53pjBrqHeHwdxri5JISd0hWvB74/wdvPY89yZtbU=;
	b=14nK58DcS52PyYysrVHnNADsg45JDGVu3h7e74FVWAZguvSTDP22yu3INbdyXn8jawTrRn
	DTDgLkYVbBZu8Kj/aeaNqcUtA8q3tqEeFKEbS+Ja7W/W8KaYBC+I3ReStG29rWUra1H4cQ
	0szW2PIK6oJ9hItgSLVA2SXW7eAFCWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718883428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/PL53pjBrqHeHwdxri5JISd0hWvB74/wdvPY89yZtbU=;
	b=1b/bJhC32so/AH8uCWjJBf6ypXXVUAw5u2kc712C60Nrup7Cp+7XM31Y31ac0aDGh7JBtc
	rxbVmlJWpEj2PsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9174213AC1;
	Thu, 20 Jun 2024 11:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sPJOImQUdGZuJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Jun 2024 11:37:08 +0000
Date: Thu, 20 Jun 2024 13:37:34 +0200
Message-ID: <87zfrf26bl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: iwlwifi firmware regression (6.9.5 kernel, Intel AX210)
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Hi,

we've received a bug report from openSUSE Tumbleweed users that the
latest iwlwifi firmware update broke the WiFi on 6.9.x kernel:
  https://bugzilla.suse.com/show_bug.cgi?id=1226544

The package from the latest git 7d931f8afa51 is broken while the one
from aae8224390e2 worked.

Could you investigate this?


Thanks!

Takashi

