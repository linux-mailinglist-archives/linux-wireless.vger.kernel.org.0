Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08479EAC6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbjIMOPy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbjIMOPu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:15:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951EB93
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lVthJDPEsDwIhqkSmVkNoWPunaskq598K/LVr4hEUuc=;
        t=1694614546; x=1695824146; b=poVgdyxEoVII/Rh3375oE0UnI7H3VAlr7Xnd4IN96qNphOn
        ylWsIk9vAhdg5oH778CHlksFvYp1sP+VITFsl7q8pUS7/bN46C1P8NjGksE7PoLbnPgzNSGFJhGZB
        BdPEGShIhE5kAvDGfWqTowyKpm8yMn50eEt6KrWSQBkzO+O9Dk9RnVFT+Qe5p9/pYWYHPWtAJM67e
        XQ8L0LAAWrmfiFN+fh20GiAGfM/LgWJCo6Oi1pGmo37eSr8RySl6KnezxnsrgCUausNBfzF32ieMa
        oy/2mGDALzCxdFOQiVMhY9Zw2CkRGIdrsuxnqrIo3v4C69hqUcF9tbNRwr6sCrgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgQed-00F0t3-1O;
        Wed, 13 Sep 2023 16:15:43 +0200
Message-ID: <1b7f8ac8e9d8d3836b0101bc7d267f3aa612405e.camel@sipsolutions.net>
Subject: Re: [PATCH 13/15] wifi: iwlwifi: mvm: support set_antenna()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ben Greear <greearb@candelatech.com>
Date:   Wed, 13 Sep 2023 16:15:42 +0200
In-Reply-To: <20230913145231.02f330def55b.I9473da818cbeeb51b2f89dcc59b00019113e7f55@changeid>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
         <20230913145231.02f330def55b.I9473da818cbeeb51b2f89dcc59b00019113e7f55@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-09-13 at 14:56 +0300, gregory.greenman@intel.com wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>=20
> set_antenna() is supported only when the device is not started in
> mac80211 which translates to the firmware not being loaded in iwlwifi.
>=20

Pretty sure this depends on a mac80211 fix wrt. chains, so I've skipped
this for now.

johannes
