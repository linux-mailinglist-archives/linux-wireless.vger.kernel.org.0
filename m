Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358DC439130
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 10:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhJYIbB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJYIbA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 04:31:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFB1C061745
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sRrD0msxG/+ng2qxnOvwKsnXBFV/VlH30hJbeQxIH+I=;
        t=1635150518; x=1636360118; b=Nx30I44Pw8xdbe3liXI3r0lVLfM9YUot4baBWC+ph0P5yDV
        594Yk4akst4J1LEbjKX9I0vypN5MfbCxfYPI7th8qtUo3O2kbMWDC/x6IAYHTbgruIzxDi/YEu8Lb
        TjHY7+c/q7U/oJ2lBxGTWTVqKHS3egANkmoqxdGb3OgOjOdYUspZMaffJEo6pImzqRrL7uJe72bxR
        8NPVES/Ulk4bQyyBcAP5iuEJJ1r3yDmTUrOFIziWwRsBcaONVr7qnyl5VbQGvnQpuO6wbYs+Kx3Ii
        I/bCzUwe20nuM0eYKd/T8SacIMGcA1XAW+YjyMQDsJJpBEVBEX6vfPw/DrczoSUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mevLO-006dQi-Rm;
        Mon, 25 Oct 2021 10:28:34 +0200
Message-ID: <1dd3525ee437ff2ccf18b455851692338af342fa.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Indicate SA Query procedures offload for AP
 SME device
From:   Johannes Berg <johannes@sipsolutions.net>
To:     vjakkam@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 25 Oct 2021 10:28:34 +0200
In-Reply-To: <7c5b87329c58ac2b68329573f587f8d7@codeaurora.org>
References: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
         <612e80125878bae6fccbb72701381832a8a6029c.camel@sipsolutions.net>
         <5a1f654e3406e99c816afbc762519fea@codeaurora.org>
         <69995d6c767edcea15ef7645fabc0e39c0dc7960.camel@sipsolutions.net>
         <7c5b87329c58ac2b68329573f587f8d7@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-10-25 at 13:57 +0530, vjakkam@codeaurora.org wrote:
> On 2021-10-22 18:59, Johannes Berg wrote:
> > On Fri, 2021-10-22 at 18:56 +0530, vjakkam@codeaurora.org wrote:
> > > > 
> > > > So how's that going to work with older hostapd? It'll be offloaded, and
> > > > then hostapd doesn't know, so it's still going to disconnect them?
> > > > 
> > > > So should be that hostapd also opts in to this driver behaviour?
> > > 
> > > yes, we have to update hostapd also with new implementation based on 
> > > the
> > > feature flag.
> > 
> > That wasn't my question. My question was what happens if you have a
> > hostapd that's *not* updated?>
> > 
> > johannes
> 
> Apologies for not clear answer in my previous reply.
> Yes, If hostapd is not updated, it's going to disconnect the STAs.
> 
> We should update hostapd also to opt in this driver behavior.

That would also mean the driver opts in and asks the firmware to offload
only if hostapd did, right?

johannes

