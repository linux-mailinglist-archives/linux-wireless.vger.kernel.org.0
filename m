Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA73C1ABA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jul 2021 22:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhGHU6H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jul 2021 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGHU6H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jul 2021 16:58:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7819BC061574
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jul 2021 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UmcHnxLom4QcF804YucUVG1Uj8/jgphTI30nZTG+suI=;
        t=1625777724; x=1626987324; b=Qf6qFNzdk5+33zMatFTn071S9PTxt/sAj4bsgWiIIhs5Szq
        506fxj1twyp2xRz1lLOraOEN7dLVb8nD+Eln146BiumUqWUekIMHeyKPnXRFvN/8GmNenLAO5BkVA
        O6BjI+Y4JbNykCYDFuMDzrEyudQCMv3Jwy8W8rtjVAT8+YGDRbW++NZI3Rp1og24w88SK2VFiSv+8
        6iGUYdRMgmJ7rlBG6v14JslBbSq7DMbYZH6qR5neR2NF6nFZAzeOFRj1N4PJ+pj0keeHmbI+D26h1
        hnlsH4SGhhn4tbIfo8OvQUoEr7Cn8iAcKkOUYcAZECNoD+6J+x3bJ3fiZEYXgX9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m1b3J-00HFcf-K6; Thu, 08 Jul 2021 22:55:21 +0200
Message-ID: <73a82bb90711f41fef58e2e6103d066c07b5267f.camel@sipsolutions.net>
Subject: Re: Issue: AX210 only works with old iwlwifi version 59.601f3a66.0
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wil <tsangares@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 08 Jul 2021 22:55:20 +0200
In-Reply-To: <CAGaza+Oh1qm9vAcNSnoGFHecwJCFt_JKMvqPqi=PaCU=pjwKCg@mail.gmail.com>
References: <CAGaza+Oh1qm9vAcNSnoGFHecwJCFt_JKMvqPqi=PaCU=pjwKCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-07-08 at 13:52 -0700, Wil wrote:
> This is my first time trying to submit a bug with kernel packages so
> please correct me and whatnot.

Looks like you sent as HTML to the list - that wouldn't make it through
(quoting it

> Please let me know if this is the wrong way to submit issues.

Please file a bug, see

https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#how_to_report

johannes

