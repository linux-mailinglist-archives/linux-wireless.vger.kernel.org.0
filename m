Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84F5369281
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 14:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhDWMy4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhDWMy4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 08:54:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95E4C061574;
        Fri, 23 Apr 2021 05:54:19 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lZvJs-00Fh3U-Nc; Fri, 23 Apr 2021 14:54:04 +0200
Message-ID: <17adb27af76820813c035874fad7e468681bfe04.camel@sipsolutions.net>
Subject: Re: [PATCH] brcmfmac: fix a loop exit condition
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
Date:   Fri, 23 Apr 2021 14:54:03 +0200
In-Reply-To: <bda7ae6b-00f9-ae0e-66d3-413049bc543d@wanadoo.fr>
References: <YIKzmoMiTdToaIyP@mwanda>
         <427e33af49758c61bc23cf1eedb6dd6964c40296.camel@sipsolutions.net>
         <20210423121110.GO1981@kadam>
         <bda7ae6b-00f9-ae0e-66d3-413049bc543d@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-04-23 at 14:20 +0200, Christophe JAILLET wrote:
> 
> > > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > > > @@ -34,7 +34,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> > > >   		len = strlen(tmp) + 1;
> > > >   		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> > > >   		strscpy(board_type, tmp, len);
> > > > -		for (i = 0; i < board_type[i]; i++) {
> > > > +		for (i = 0; i < len; i++) {
> > > >   			if (board_type[i] == '/')
> > > >   				board_type[i] = '-';
> > > >   		}
> > > 
> > > It should probably just use strreplace() though :)
> > 
> > Good point.  I'll send a v2.
> > 
> 
> and the 2 lines above look like a devm_kstrdup.
> 
> The (unlikely) malloc failure test is also missing.

How many issues can you have in 6 lines of code ;-)

johannes

