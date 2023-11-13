Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982DB7E9A9C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 12:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjKMLAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 06:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMLAM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 06:00:12 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF2ACB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 03:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Q1AP6rnrmNJWBf9danG3du/xAdz3oTx/QQttEyW2IB4=;
        t=1699873209; x=1701082809; b=Qujy6XEuQcfEHMVt3sFpWi7l4HsRfZVEVUwcPSQpTmc+5VH
        Q6yLgfbgCV11YwaGMfim+FDLc0+BngsQMSduc9ZburSgaJSrU3TI8NNvDRMRJxUf5S8+vnHHdjNlw
        KLZooKXDjI50R7DsF7seU7W4l2hkn5GKEW8L112ajRvd7kdf5ag0de5ZpVDeC6ahvZrgDix3fCBE/
        H3ACxL1mD9MKrMgF1HCqB6azfEutyK81Jaz/qya4vCvgLySi8MZTVqg1C0/wfF+KSM8sRw9UoElpN
        CIZfaoVOIOj7qoH2aEWtfasFmSmorfaY4ueEYlyMlt/Xj33b2xRKDcWqaPeLaosQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r2Ufm-00000006esb-2Saw;
        Mon, 13 Nov 2023 12:00:06 +0100
Message-ID: <60af992733c7cf026cb0512027045b31cd74a164.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] wifi: nl80211: Add PTK/GTK rekey interval
 attributes for APs supporting PSK offload
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jithu Jance <jithu.jance@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, vinayak.yadawad@broadcom.com
Date:   Mon, 13 Nov 2023 12:00:05 +0100
In-Reply-To: <20231113104232.97803-1-jithu.jance@broadcom.com>
References: <20231113104232.97803-1-jithu.jance@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-11-13 at 16:12 +0530, Jithu Jance wrote:
>=20
> + * @NL80211_ATTR_PTK_REKEY_INTERVAL: PTK refresh interval in seconds for=
 drivers
> + * supporting NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK.
> + *
> + * @NL80211_ATTR_GTK_REKEY_INTERVAL: GTK refresh interval in seconds for=
 drivers
> + * supporting NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK.

Please indent here too.

johannes
