Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0E79E3AD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbjIMJ31 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbjIMJ3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 05:29:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0531E0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TQ4H4+5UEjJOeGCQe+dYsONPpdDZhbalRCDkfTb9DAA=;
        t=1694597361; x=1695806961; b=Fg65ZLaTzGRVVUDaQd1Opio3mWBkG8xXKrLD3MQ5jm0PVkC
        IgUpXLbm5rTgjXSY93dG4rJ60fNwm0kS5nk6fezGwd/+yT7R8y0zTjQwd+L7+dX85Bi5MCOupu0Kc
        wtqZx6bwc6nzMhx8TFNGFeowIimx1eSNTqaQn8uPIfuH1ZZwm3osZGobxu89EKmY0Ld8XW2Pn471x
        gpeaT7sMUxVqJpwByejSP2iEUaKiwLmaVZgiMcX7RdyrV+WpQ142DBeqDkB5S4dAp4mh7/UBk+BFi
        xrLa9uoKW2GmQW0y5/MYhCfBHZmXTUhCmwALl6CXNltENUxNvks+gWThvqTyME9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgMBT-00EjVY-0x;
        Wed, 13 Sep 2023 11:29:19 +0200
Message-ID: <f436ea028da7b016241f307348286be6cfe7df65.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] wifi: cfg80211: export DFS CAC time and usable
 state helper functions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Wed, 13 Sep 2023 11:28:54 +0200
In-Reply-To: <20230912051857.2284-2-quic_adisi@quicinc.com>
References: <20230912051857.2284-1-quic_adisi@quicinc.com>
         <20230912051857.2284-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-09-12 at 10:48 +0530, Aditya Kumar Singh wrote:
> cfg80211 has cfg80211_chandef_dfs_usable() function to know whether
> at least one channel in the chandef is in usable state or not. Also,
> cfg80211_chandef_dfs_cac_time() function is there which tells the CAC
> time required for the given chandef.
>=20

Should we really export the time function just for a debug messages?
That seems like a waste of space?

johannes
