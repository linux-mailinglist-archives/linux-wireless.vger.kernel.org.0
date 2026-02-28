Return-Path: <linux-wireless+bounces-32305-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFgDO9Y9ommq1AQAu9opvQ
	(envelope-from <linux-wireless+bounces-32305-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 01:59:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 988B81BF90D
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 01:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B8930593ED
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686F6274659;
	Sat, 28 Feb 2026 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="JLTbwC9D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31E27281D
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240340; cv=none; b=GI7wDZhjv52wevssAXjXqi3MylYv42mWnfytJxzNb9CXUP8Qli1abPAPwpDT5TKsZlwOZ8d7H03aS0VyYVFdUZ3rMjidKrNld7rNT2tfRR7JPaNf8+2tKnSvNtYE/WcMa54ZCqxjXaHVg/GbVNOfVruRgjldZAQ7ZnkFpnUMvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240340; c=relaxed/simple;
	bh=8AGUUbzD7hoVZZcXwqxP49ABW+GHA9cKsI0JaEOtSD0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=csRcnyBY7a0FsI6cRkyCvVM3V9kGpqDKQbiTmzJJ0UAr4jzLnGd4k4l5/COjqzSJn/UlGC5qsoDKqIXGPz9WYxXCCEGgRWaXaFqtZ4Wsm36BrlMrcIF8pRUpCviuBMYM8xhm0vKCALL7jzQFLCdUx8DgFjcjW8CHqQp809gmRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=JLTbwC9D; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E9BB8C00072
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 00:58:55 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4E25913C2B0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 16:58:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4E25913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772240333;
	bh=8AGUUbzD7hoVZZcXwqxP49ABW+GHA9cKsI0JaEOtSD0=;
	h=Date:To:From:Subject:From;
	b=JLTbwC9DRm/B6wEA2Li3KJAlrTV+3YM+BBN6mcc81dI+/clx1lGA2QpcbkmwGxXBS
	 Q8ylpVLZGl9aCghowcnO0Wq+KWycp1H413/VCxkz+L84FZXNI3drbWWUh1i7T3/lQv
	 bErVCpiu2PtP0FsQHdsAiSHE0x7Gy/fQYSTR4hEE=
Message-ID: <40a9eca2-17fb-b839-e31f-eb4aecb2ca41@candelatech.com>
Date: Fri, 27 Feb 2026 16:58:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: Maybe problem with ieee80211_tear_down_links return value.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772240336-85AGTYCX0v9g
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772240336;85AGTYCX0v9g;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-32305-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 988B81BF90D
X-Rspamd-Action: no action

While checking on some other problems, I ended up adding logging to the code path
below from net/mac80211/link.c.  This path is hit very often on my system, and if I understand
the code correctly, it should only hit in error cases where MLO links have duplicated
MAC addresses.

	ret = ieee80211_check_dup_link_addrs(sdata);
	if (!ret) {
		/* for keys we will not be able to undo this */
		ieee80211_tear_down_links(sdata, to_free, rem);

The ieee80211_check_dup_link_addrs method appears to return 0 when there are no duplicates,
and -EALREADY when there are duplicates.  So maybe the check above should be reversed to be:

if (ret) {
??

static int ieee80211_check_dup_link_addrs(struct ieee80211_sub_if_data *sdata)
{
	unsigned int i, j;

	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
		struct ieee80211_link_data *link1;

		link1 = sdata_dereference(sdata->link[i], sdata);
		if (!link1)
			continue;
		for (j = i + 1; j < IEEE80211_MLD_MAX_NUM_LINKS; j++) {
			struct ieee80211_link_data *link2;

			link2 = sdata_dereference(sdata->link[j], sdata);
			if (!link2)
				continue;

			if (ether_addr_equal(link1->conf->addr,
					     link2->conf->addr))
				return -EALREADY;
		}
	}

	return 0;
}

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


