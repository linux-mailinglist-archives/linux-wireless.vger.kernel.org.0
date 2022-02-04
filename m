Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632AA4A9E20
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 18:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377127AbiBDRpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 12:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377167AbiBDRpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 12:45:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE86C061756
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=84HCN+wDIh+Fgo/WE7GRZPHK3r+GD/poUhPPqyKaB9M=;
        t=1643996734; x=1645206334; b=HHzkoz9lJ41Jocr4xG51bRSyw/3s6nq4BmITQO2GnZUwCsQ
        mpDb8pd7z0VSxsOvfSc3/gvijm/Lzw7eLHyVdUNEP0DP1gkq86ZOt/ehVM+BDe21eqIBnwOX2rla6
        CvTB8dIMzBuotPzr5VQkEsGVpbIUvPjN+bYXDfaZUsIh3b2vK15O5PkFietiqiJ65/jQWC+OzcV9n
        SYg9GmXcXcjjPAsMwlinuyBxLstZ0jRgYvkO5Td/Y8tIIR00YgQVKU+Vh1JLoJxzHrO1DZW6w0SSJ
        2Jai7drDjT6o6MXquFY9IyuoC1H4v1G5EfJyaYnGMv8caqsYpwT+QHc38apP3CyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG2eK-00EZ7J-Fi;
        Fri, 04 Feb 2022 18:45:32 +0100
Message-ID: <6f175b75991159fe99abb9efbcb105eefb3734db.camel@sipsolutions.net>
Subject: Re: [PATCH 3/6] nl80211: add support to send EHT capabilities from
 userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, quic_vikram@quicinc.com,
        quic_alokad@quicinc.com, quic_jiad@quicinc.com,
        quic_periyasa@quicinc.com, quic_msinada@quicinc.com,
        quic_srirrama@quicinc.com
Date:   Fri, 04 Feb 2022 18:45:31 +0100
In-Reply-To: <9bd12810-19a7-ad74-6577-d43c4b2ab9e5@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-4-git-send-email-quic_vjakkam@quicinc.com>
         <5ede1e1ad04b6359eafb658e827abf6a8343355f.camel@sipsolutions.net>
         <0644274d-7a9f-642c-eef2-02c662a5adcc@quicinc.com>
         <0c0ba8cebb877384172b5bd314cbbbb035d1f348.camel@sipsolutions.net>
         <382a29fe-dea3-7d32-2aeb-16ba18e9da28@quicinc.com>
         <91d3b826accb22194c9fa3134cd1f3137950e863.camel@sipsolutions.net>
         <9bd12810-19a7-ad74-6577-d43c4b2ab9e5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-02-04 at 23:13 +0530, Veerendranath Jakkam wrote:
> 
> 
> > Also in your later nl80211 patch I'm thinking we should combine the
> > HE/EHT GI settings etc., there's no point duplicating all the enums,
> > though we might want to do some renaming.

I actually just decided against that ... it gets messy because we still
need the attributes, and the GI is the only one that's entirely the
same, so I think probably duplicating that is more understandable (all
the EHT stuff belongs together)...

> 
> meanwhile I will upload new patch set with the suggested changes in last 
> patch.

No need. I'm doing rework on this, and we also have mac80211 assoc
patches, STA capabilities, etc. I'll send it all out soon.

johannes
