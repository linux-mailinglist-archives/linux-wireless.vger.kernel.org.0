Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9C4E22BC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 09:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiCUJAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 05:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbiCUJAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 05:00:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA42637
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rcvqZqPrBbD/86qEasWL/HDztHchLovqQk7d/zkEWnY=;
        t=1647853100; x=1649062700; b=CfNSpGI2iRla2kYUrcdKXyTd6LsNzWY0bZPoaGmYxQpYtBB
        xcGQ42MuJUx8IHDABqkWn4Fo9FPPp7DQ5w3QgVaNar5ThoXhgP0IEbgJLSv2ZuqtkcG7K+xqeibP+
        DYvtuk6svVhv28UNzdaWe4xjXNU+H79RApKyT/YoBrsGC7dMVEoCw8s8zCm44jbo0mbnEhJ6sDDF3
        5XPfsQQW+jY37hbamyJrNngdjo9CdJGciGqDi4kZaLlARZqGgSj3BIjcgRGFoclSraTwsLzqipbSz
        GoZEkl3YRDmf+btGlodyXAHnrHwCkxszVRq35cFia+AxiuhKP7V1XuDIpvPeanXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nWDrl-00G2r9-J6;
        Mon, 21 Mar 2022 09:58:17 +0100
Message-ID: <a537c6e02afbfa26eec2a54dbd8bc649f77ae3a3.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Date:   Mon, 21 Mar 2022 09:58:16 +0100
In-Reply-To: <DM6PR02MB4937C53041172E9A52846A0BE9169@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
         <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
         <a517835c51a5eaf00e87fdaaef47546f70ff0d42.camel@sipsolutions.net>
         <DM6PR02MB4937C53041172E9A52846A0BE9169@DM6PR02MB4937.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-03-21 at 05:12 +0000, Rameshkumar Sundaram (QUIC) wrote:
> 
> > 
> > I am wondering though if this should even be detected from the HE
> > operation element itself, rather than from the beacon rate settings
> > that are
> > separate in nl80211?
> This is a BW dependent bit in HE Oper IE and user space can switch BW
> (CSA/chan switch scenarios).
> Which can call assign_beacon directly, Hence adding the logic here to
> cover all Beacon change cases.
> 

Yeah but still ... why do we take it from the content rather than adding
a control for it?

johannes
