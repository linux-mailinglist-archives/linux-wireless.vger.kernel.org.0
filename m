Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0061E775B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgE2Hom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgE2Hol (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 03:44:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AACC03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 00:44:40 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeZgy-005O0Y-0O; Fri, 29 May 2020 09:44:36 +0200
Message-ID: <fe9251f1e68e1065e37d60c57c22c9f1ad70bc80.camel@sipsolutions.net>
Subject: Re: iwlist scanning: how to exclude old scan results from output?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bruno Dantas <wireless@dantas.airpost.net>,
        linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 09:44:35 +0200
In-Reply-To: <c921f6e0-8b27-475d-9441-28025d5afe83@www.fastmail.com>
References: <afef8a7d-053e-4aaa-ace7-d320c32e8b7c@www.fastmail.com>
         <(sfid-20200528_174911_413757_32DBA783)>
         <a185a4283c1230965b520de52737427c91af9c22.camel@sipsolutions.net>
         <99c4ece3-15ca-42cb-aa09-c86d466d6429@www.fastmail.com>
         <7406af4a9e852d99735e1b1af63deed2f0c5d703.camel@sipsolutions.net>
         <f78191c6-3093-4d97-a959-068dce1da552@www.fastmail.com>
         <6d5994325bbb28ff855b527a26e4e7e87760705f.camel@sipsolutions.net>
         <c921f6e0-8b27-475d-9441-28025d5afe83@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-28 at 15:06 -0400, Bruno Dantas wrote:
> > That's why 'flush' exists :)
> Alas, mine seems to be clogged :)

Evidently :)

> > Obviously. But still, now I'm wondering if there's a bug?
> > What driver are you using?
> My adapter is  Atheros AR928X  which uses the  ath9k  driver.

Hm. That should be fine.

Well, I don't know. It's weird because the timeout and flush are
basically exactly the same thing!

If you want to debug it, I guess you could start with something like
this:

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 74ea4cfb39fb..6fe609f6cd0e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -483,6 +483,7 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 	if (!request->info.aborted &&
 	    request->flags & NL80211_SCAN_FLAG_FLUSH) {
 		/* flush entries from previous scans */
+		printk(KERN_DEBUG "flushing at %ld, start was %ld\n", jiffies, request->scan_start);
 		spin_lock_bh(&rdev->bss_lock);
 		__cfg80211_bss_expire(rdev, request->scan_start);
 		spin_unlock_bh(&rdev->bss_lock);

Unless maybe it got into the aborted case?

Maybe before you even do this, run "iw event -t" while doing the scan
with flush.

johannes

