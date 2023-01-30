Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C86807B4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 09:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjA3Ipe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 03:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjA3Ipd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 03:45:33 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE10868B
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 00:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tjQIOzrEJ+KPJrAivSTFa60erZft6Z98CzjUFbPSJCQ=;
        t=1675068332; x=1676277932; b=I+UPUQN3ExoBqOuNFlNSd+ebj5AenutynFeSrYW0mwZ2k9c
        5ghogbQWeiQ0kv/Moc15AJX2Hp6hLl59AAaEF+OXoB3+vXma/W1EmjUqoDb0+66fMLf0AcwuX8vV6
        n5ZMcPpM2aU1rUxxH2uiWcpWJjKZ9JXLbHmAoGGGMp5AGAHfVXni3L0fdhiZ/9qo2CxPkWIf0/v0O
        WI5X0gdZfXMHGb2vuIcMPsojhDxKZy23SuIprP5809V/9fJXMesXNZcdPniRx65mIR8rNZxTWAloD
        hY1hQ3NSiv4W1NXDKn1e21pENgPyPHCt25njQuC5Vc6XmLR0DRXfSwbtePkuIWhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pMPn8-00G1JO-22;
        Mon, 30 Jan 2023 09:45:30 +0100
Message-ID: <91f8553f190069da19c907c1819f8ae5c40ceb17.camel@sipsolutions.net>
Subject: Re: [PATCH v3 5/6] wifi: cfg80211: add puncturing bitmap in channel
 switch notifications
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 30 Jan 2023 09:45:29 +0100
In-Reply-To: <20230130072239.26345-6-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
         <20230130072239.26345-6-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2023-01-29 at 23:22 -0800, Aloka Dixit wrote:
>=20
> + * @punct_bitmap: the new puncturing bitmap
>   *
>   * Caller must acquire wdev_lock, therefore must only be called from sle=
epable
>   * driver context!
>   */
>  void cfg80211_ch_switch_notify(struct net_device *dev,
>  			       struct cfg80211_chan_def *chandef,
> -			       unsigned int link_id);
> +			       unsigned int link_id, u32 punct_bitmap);

Same here: u32 -> u16 since that's sufficient

Maybe we can keep it u32 in the trace, not sure that matters.

johannes
