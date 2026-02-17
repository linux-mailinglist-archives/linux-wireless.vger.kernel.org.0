Return-Path: <linux-wireless+bounces-31950-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO0rD+5vlGk0DwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31950-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 14:41:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DD614CB52
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 14:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 671A73060BC7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CE35893;
	Tue, 17 Feb 2026 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="WvJmb5tz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i207.smtp2go.com (e3i207.smtp2go.com [158.120.84.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080E36AB66
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335551; cv=none; b=BjicE3KeHQakOHpPa45qAtSnBcvo6ojTI9frguVbyc1FLoSmWWSltcBVXkY6DSyUSEhTEwLpElbKvpOS0Qb8Vw4VrqYh8avkpJj6SjW9Ve3YtbnV8tSsH2+fPMazmbqvgG4LewE66NxrdPsbIH0Mw4j+5RCnMgaxYU7UpSAAyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335551; c=relaxed/simple;
	bh=5Mhe4SHmdFJJwuXBCn5tVcEJ/+LjMSjti1wjYkkdBF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiVYzdOA65EM6MWN26n9jr77A1W0bb/eZNUZjhwZLkFzdYUrIy042OZW/l5oZltKPZWuiv0eddfeEM8havKhH+MRB1zJiPhvvFfK2gMC3LHlOBIIAGob7oEaZrqDpj1AugCfUSRxD4pfA8Zk0kx316kroubaoSMXWRoRyWno3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=WvJmb5tz; arc=none smtp.client-ip=158.120.84.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1771334639; h=from : subject
 : to : message-id : date;
 bh=robDNmnieWjOptib6IYbtmkQe43LQOtTLbAFyHIKkKk=;
 b=WvJmb5tzx7n4gUk5m8nHPkenuXS/SLDJsWvep35F1RBQkSne7vQNvR5hlWLujVtQJOTe7
 h174gqhSpUz/p7gPUDxgEfmGdpgND6d1muDE9uHNFgACCd3xOUMQGtP0xusJpD7c/4QU2UC
 fa5KbmSfx/locHY5pi270+X1RC5l/FSWjWtEJSIVhmFRGMfyfSy5frO1I+FoaYZl6BmWQt6
 HqxUJ1D8EfT0qBnMC6h7KyS0LS2cl96qCmTDr90FTunTykD0XxQlzyAhbMBRV8wJiJslFGa
 UsNm2EdSsAPVMbtxx5w9OVp0SwOd8xb2DkouvkYwPr8sMOehfw/izZHaypMA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vsL3U-AIkwcC8mK9a-KauJ;
	Tue, 17 Feb 2026 13:23:56 +0000
Date: Tue, 17 Feb 2026 14:05:24 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
Message-ID: <aZRnlPA_uY9uWuKr@pilgrim>
References: <5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
 <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sbru8S-D2W
X-smtpcorp-track: LsngSrkFNPC3.mlWRuKFttbwk.lv5eDwL1Lzj
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31950-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81DD614CB52
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 12:30:08PM +0100, Johannes Berg wrote:
> On Tue, 2026-02-17 at 11:36 +0100, Remi Pommarel wrote:
> > Commit f89e07d4cf26 ("mac80211: agg-rx: refuse ADDBA Request with timeout
> > update") added a check to fail when ADDBA update would change the
> > timeout param.
> > 
> > This param is kept in tid_ampdu_rx context which is only allocated on HW
> > that do not set SUPPORTS_REORDERING_BUFFER. Because the timeout check
> > was done regardless of this param, ADDBA update always failed on those
> > HW.
> 
> Seems like a legit problem, but
> 
> > Fix this by only checking tid_ampdu_rx->timeout only when
> > SUPPORTS_REORDERING_BUFFER is not set.
> 
> that doesn't seem right? Especially the way you implemented it, it won't
> even respond at all when it's an update and SUPPORTS_REORDERING_BUFFER
> is set.

I could be wrong but I think the patch format here make it difficult to
read. If it's an update and SUPPORTS_REORDERING_BUFFER is set, the
following "if" in the code (not fully visible in the diff here) will end
calling drv_ampdu_action().

> 
> Seems we perhaps just need to store the timeout elsewhere?
> 

That is another way of fixing that yes, but the question here is, don't
we want the driver to decide if it wants to support timeout update ?

> > @@ -374,14 +383,6 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
> >  			goto end;
> >  		}
> >  
> > -		ht_dbg_ratelimited(sta->sdata,
> > -				   "unexpected AddBA Req from %pM on tid %u\n",
> > -				   sta->sta.addr, tid);
> > -
> > -		/* delete existing Rx BA session on the same tid */
> > -		__ieee80211_stop_rx_ba_session(sta, tid, WLAN_BACK_RECIPIENT,
> > -					       WLAN_STATUS_UNSPECIFIED_QOS,
> > -					       false);
> >  	}
> 
> Also, nit, but this leaves a blank line at the end of the block.

Sure will remove that if we finally decide to keep the fix as is.

Thanks for the review.

-- 
Remi

