Return-Path: <linux-wireless+bounces-35537-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHBZENMg8WntdgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35537-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 23:04:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E678448C305
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 23:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3F8130364B7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D2137B409;
	Tue, 28 Apr 2026 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="SiHaxxoU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981D332638
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410163; cv=pass; b=rf3ErHMEa01WAIQhJnyUPSu5wydm4BCg2cCVXwzkyvbnVNRRj3RV0T761ltR5KPxzS/MDBW468JH1sEewl5/6fQr0IOAvhGmhAcgorBydifAqXkkglkiKifNHychzPEdzk6aoXv6ETJvuEuca23IMpqa3jh9KdLC/x1lwslX0Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410163; c=relaxed/simple;
	bh=QZ5g0rywRPmTuJ69hvkprtR7MFhY68sDBLhcgw0FtUk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DzHoTN1xYtp/jkbcn9irhf6txT251CEjhLUQeCIe1mwe7kMGOlqA9qGn4hukzmUI/sfo6GsqsJDZvs8I0Bc9vWFqZgAsiMtVUkPMgDUf7t5YqkTn235KL3zGQmTvo5DaFQAiv5FXPRiY3NUCeWgCItKok72nPp2CKraMor4bX7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=SiHaxxoU; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c79467f11abso8030606a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777410161; cv=none;
        d=google.com; s=arc-20240605;
        b=aOj3jHr2+mKDR7URiovs11podpvMO2TBEnHkXC+I+jxdvKgED2IniskpCG8QKg5qTZ
         msO2g3Ja5ziVe5lm8GNf0g0v/wC/JACw89kxRENSoBLeQu3pLNqD5l60z+rdJbCZxFe6
         lTdblW9FkZykvZBOVZcy2nbjA/1x2wCG4qKJFvjS/3gl4WQlBuU8vrqNO6XX21wCUva5
         MCHt/Qdj+V4tC92q1KLGICnyZVVd27kc2yDUvKhc1e86+TecpKq0n8ARo+J2bQ8APwXS
         95bd83tr6ITMSu5YUJFIcreFrep7HY7s+Tl+sp+EX4i7sAIvY2LME7Yu6l2MrsODvSM6
         8kdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QZ5g0rywRPmTuJ69hvkprtR7MFhY68sDBLhcgw0FtUk=;
        fh=4f86iDwlbvwK7fjol43BdqWofzi59L5oebHx2iNZDlQ=;
        b=YDnvqlpP+VsBs1nYHFxMfHC/xFiPK97P2AwbOPO65HKu3xz/h7fkUSpFNMqW9FpQW/
         rQlloSBmEKGM14cbRdv5GMFDLc+Ap5w9WOKWeDiRngM8gOh1O4tcHAVjCEhgL6gLKOct
         t4knryhSPDcKf96Zf6G2kHPpMTgg4I6UEH/52lDyCK30NVJbSkMVNq+m0XKyQDPC9P6b
         2LM+KrJPd3prt81T9S/FVO0h+0wNPWTJPVq5t5CIdeQswfykAd6hUUyneMWGXXXLvvan
         sYuAucMH+Lhy8+p1VE7Yf2MA9WOqr8kzibcElC+TCHRvsg7hQMTZ2JwBz0VylHbFC72M
         cQRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777410161; x=1778014961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZ5g0rywRPmTuJ69hvkprtR7MFhY68sDBLhcgw0FtUk=;
        b=SiHaxxoU4y/Y2KPdUjP5E1imfmZialfvd/cWpcEqFEvAe6q3YrReObRIgOm9QdUgiy
         omiqDXA3o/pcWVR+w37kVsh6xf8knA3bem6ruW96/fx0y9GK13FQYckQ0Xfgf8csyMeJ
         +jGoNoiBStSHfXyEmqgiG/1AU7yw2n0mXS/i1Cb9+BKYfT7Avt+AaDwmvcSBJWjJNkFo
         bBm3+8EEQdw9J3D4NJtM5b6zDYQKLcfZpz5AsGoEbqyuEoyJqvNatqhJlYuhBVikR4+t
         DQ7AJ7MegJq48WX/jfB5brsaouFW7v4KMXHm5pup3XvvZbS9HPuKaKyZifysD0lUkB02
         YNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777410161; x=1778014961;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ5g0rywRPmTuJ69hvkprtR7MFhY68sDBLhcgw0FtUk=;
        b=mI1Z19+D1OyccQfeECL0Lb9hwhIKvom18HGNXqzDTHzNjqkvGuLYIDRQu6SwlKSQyy
         FULtdutfMdxnp0kuhQDuLmgZZ4xv4W1/pkKeOJeYpvAx2yejHs4gBeeHEL9CcvcRqpzG
         t/AVCPKZN2JXsgWJ/bSvarv9+7KbqKkyyfecubSam9APUcAawfi6hCqZZvTKfl6ArXtT
         j/Syk+zOg6sA22YWolt7pOVfXcCd170TmOC7ZlKCLFdJ3d77Ypo7H6lOES7is5KMVWN/
         exC0+x0eJsZOCggxhpeESZZRwhVFmve7qtUgpgrCu0NboGAEXpWzsrKyChc8uHF/N4M+
         OR1g==
X-Forwarded-Encrypted: i=1; AFNElJ8QHWSjIT1m0aQMwVhIy1RdpPskZMqQVMFucunnMnRu2zCt9PUu5tt4xiIhYHhkTnp9cGajsvbTwoD/i35W8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO02zv0qXau/NT1WJCA6tq06vi9AMKGuXDcQ+EEgOvmE/X7h77
	C0L3VwqyhkhwHd2u3/bjHYqRonLO+xS6NBGHxxBkdb3NCcIwTo3DNCBWb4Sh8a2dogrKQUqqG7h
	ZbU3BBhrd4x53kkkaY5Z++/C5it9Kkikb7Rac3ULS
X-Gm-Gg: AeBDiesKXvwSb6q89HjAllDo45jrzOS8be1E/v8umNO36uUTtN73Fh5Zh45NRmpCSSA
	q5jeEuwF9k6yLAz5hcX2tL7wkC0vfpxMtLz8z2yG2E73f6K5H81LbrrzlJjUiZAjl0udzuHUHni
	miRxE8PTwMnTfArovQSzK3AYdGOADduKrYbyCkHD7ZBKrW3kdNLkGrb1bE5P30S/2xN60yYmsr2
	BhOkMrSj1k2GZHiPPVFFFrBSpS2Qn2NChd6iClDQo8TbwmD+V1F31ewODQ7KceC7RE6rTD7Syko
	spXmLPN6a7OEw4tnwfq5pezdRS8BEA==
X-Received: by 2002:a05:6a20:9146:b0:3a2:df61:50e6 with SMTP id
 adf61e73a8af0-3a39c3da898mr5265488637.47.1777410161237; Tue, 28 Apr 2026
 14:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 28 Apr 2026 17:02:30 -0400
X-Gm-Features: AVHnY4IPbL50MGY9wUIpXRQqsPuw4TFCQyKCgR4OtAo8xSoWCQRt5lBPiF8oDqQ
Message-ID: <CAM0EoMnv9ZDWFSDGMK3iX9dXjXNLs+v30ak-GgsLBq3EQ+hQsw@mail.gmail.com>
Subject: 0x1A: Call For Submissions is now open!
To: people <people@netdevconf.info>
Cc: Christie Geldart <christie@ambedia.com>, Kimberley Jeffries <kimberleyjeffries@gmail.com>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, lael.nasan@gmail.com, 
	PJ Waskiewicz <pjwaskiewicz@gmail.com>, program-committee@netdevconf.info, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E678448C305
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-35537-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[ambedia.com,gmail.com,uniroma2.it,netdevconf.info,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_ENDS_EXCLAIM(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,netdevconf.info:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

We are pleased to announce the opening of Call For Submissions(CFS)
for Netdev conf 0x1A.
Netdev conf 0x1A is going to be a hybrid conference with the physical
component being in Rome, Italy.

For overview of topics, submissions and requirements please visit:
https://netdevconf.info/0x1A/news/netdev-0x1a-call-for-submissions.html
For all submitted sessions, we employ a blind review process carried
out by the Program Committee.

Important dates:
Closing of CFS: June 1st, 2026
Notification by: June 10th, 2026
Conference dates: July 13th-16th, 2026

Please take this opportunity to share your work and ideas with the community

cheers,
jamal

