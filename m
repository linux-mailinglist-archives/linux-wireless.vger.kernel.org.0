Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5014A94E1
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 09:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbiBDILL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 03:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiBDILK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 03:11:10 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA6C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 00:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0Svaz5Rafy/bGOpNG44QwvCv43k24COhHccSmWjxFKY=;
        t=1643962270; x=1645171870; b=QIjnBDEGc8+YTFiF3XAno0BqX6L3Pm0eGbAEDWdf70egw/5
        Uzb/iUB4hD0Mfm2Iw3pwqHtUdKpVEuLtggcKDT//T5YJwtfw/7M38HkURVaHTxcAq0zqkXBpDXHwy
        9gKPa0NgOIIaadhqGKUNMlwcZ5YxlPmKq8AtBrtz+t/Fl1PEohdBBRiW9ECsoHCwFYW6S/okRXyp0
        oXQSVsLl1I2jxzgHsqM9YeNMHgm0fCc6ri/8Zr0pzuTNcRT2EVaQmw2ab3ceg/GF/WX0KGDIUwWUA
        pyrdMv/q6errRyg4zO8Sn5Fqfe7JQMGPnZde2l+Sujt44NM04tFbjN9uOEc0j9mg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFtgR-00EPot-M5;
        Fri, 04 Feb 2022 09:11:07 +0100
Message-ID: <0c0ba8cebb877384172b5bd314cbbbb035d1f348.camel@sipsolutions.net>
Subject: Re: [PATCH 3/6] nl80211: add support to send EHT capabilities from
 userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, quic_vikram@quicinc.com,
        quic_alokad@quicinc.com, quic_jiad@quicinc.com,
        quic_periyasa@quicinc.com, quic_msinada@quicinc.com,
        quic_srirrama@quicinc.com
Date:   Fri, 04 Feb 2022 09:11:06 +0100
In-Reply-To: <0644274d-7a9f-642c-eef2-02c662a5adcc@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-4-git-send-email-quic_vjakkam@quicinc.com>
         <5ede1e1ad04b6359eafb658e827abf6a8343355f.camel@sipsolutions.net>
         <0644274d-7a9f-642c-eef2-02c662a5adcc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-02-04 at 12:42 +0530, Veerendranath Jakkam wrote:
> > 
> > I calculate only 51, based on the assumption that we can only have
> > NSS==8. Even if you think NSS==16 (which I doubt), I get to 80 only?
> 
> So total max length would be 81 bytes
> 

Right. Now I don't know how I got to 80...

Regardless, I don't think NSS>8 is actually valid, the PHY spec always
says it's max of 8, so I think we can safely limit to 51?

johannes
