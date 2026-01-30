Return-Path: <linux-wireless+bounces-31361-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IATG6mhfGlxOAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31361-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 13:18:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82774BA6B0
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 13:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BFA23003733
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F7352C57;
	Fri, 30 Jan 2026 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="QjDv4GZf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868732C925
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775523; cv=none; b=IsE1XGcwFuX5p5AnCo9W0NZMzhh7KbUZh+RqkvYusG/7CRjENgDTydCbBSZmkEkv4hKRiGedfFp0oXdhEsgEpx6Zl7xa5Au8pVTSNEwwNp7BI0cGUKMust/BF5QuC4CYzs2FwWXX/PrikwJFlOr2PQrKCNBKRi8mtuAGPo9qn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775523; c=relaxed/simple;
	bh=WMQYC2ECElU+Yo72RuzWdoSlpVJpi22L1B5urUcreuI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=thRIv3DjCaPfHxYjWAfLeHLi1dpWaSnCW0UWAE7A/UNt6ikaoM+VNZpAGXB6RnlQOa2d46EcuoHZJxmWNO9UU5lO2KNgS6/uicvR2MqA5vDx5bY8aLxN8sjRPkMupVPB5qblJ+cTweO68uVlQmb9HSHsoTiMZnm1YgETDyHu6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.hopiavuori.net; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=QjDv4GZf; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.hopiavuori.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EQIITpPRApet7+SQPGzxWI2DjJmP0PMYqzH0v5ZTA10=; b=QjDv4GZfQj7J4J84McOeuFhmj8
	Cg9DOlA8wovTacha/sX8cvlWrgImjJoWQvuavqA4tYWlA7NnzSGwxOXjqs+SKLXhNY9mW0qrO69fI
	6jw/MvDRxuae9bicOgLwmhhugZWg37klBMtdA2H08LJvp0BTQLu24jgswTpspoIjB2dlwdhmlrxEe
	BrsD9YpvtKlc2KsEeDszUfzyXYojE0HcMFAxLYBeT03426kXTmmtXLjXd6aE7rYBPGTKUYt0aLI6g
	JsvnOiMy+IRXb1XNNgGUSvCV2fk/dQljCWKYPg6wkxjBaMCCDA47Anp9k1Z9QTPQ92PANkO6nWvS/
	BgHVnmiA==;
Received: from dsl-hkibng41-567305-225.dhcp.inet.fi ([86.115.5.225] helo=[10.0.100.21])
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <linux-wireless-mailing-list@mail.hopiavuori.net>)
	id 1vlnSM-00AE2t-2y;
	Fri, 30 Jan 2026 14:18:34 +0200
Message-ID: <89e415cf-246f-41aa-942e-132be83df632@mail.hopiavuori.net>
Date: Fri, 30 Jan 2026 14:18:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list@broadcom.com
From: Utu Hopiavuori <linux-wireless-mailing-list@mail.hopiavuori.net>
Subject: brcmfmac: iwd fails to connect on multi-AP networks (MacBook Pro
 12,1, BCM43602)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.115.5.225
X-SA-Exim-Mail-From: linux-wireless-mailing-list@mail.hopiavuori.net
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[kapsi.fi:s=20161220];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kapsi.fi:-];
	TAGGED_FROM(0.00)[bounces-31361-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[hopiavuori.net];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-wireless-mailing-list@mail.hopiavuori.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 82774BA6B0
X-Rspamd-Action: no action

On MacBook Pro 12,1 with BCM43602, iwd 3.8 fails to connect to a network 
with multiple APs under the same SSID (connect-failed, status: 16). 
Non-free firmware loads successfully; no NetworkManager installed. 
Workaround using wpa_supplicant works. Applying options brcmfmac 
feature_disable=0x82000 allows reliable connection.

Debug/logs:
* 
https://p.kapsi.fi/?955065d6c0d0caf1#D8NZwkNPxayrNRWHxR8UofT3htVDRw64nu5SG41v3BvS
* 
https://p.kapsi.fi/?58aefcff5920f733#F4MdmgRbmTUtgsbVm76ixMRwFktkZMJEuwCW9ZLQMNJo
     - Boot 7db8fc4051a14fba8c19086100bf2f0d: before fix
     - Boot 2bf8b79cf80c4abb95b2ad8c074a4249: after fix
     - Boot 402b96dbfcc44b5c9d31bf5f15af8bf5: always known-good-network

--
Utu Hopiavuori


