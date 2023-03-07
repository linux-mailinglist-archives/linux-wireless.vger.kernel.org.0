Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC676ADBD1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCGK03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 05:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjCGK0B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 05:26:01 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8B73000
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YwJXWD0MDXVNZ2ibphqL8840tSWKwNoU8XBL/5S5r4s=;
        t=1678184743; x=1679394343; b=lZdRr8zVTl1HrYeNRYpTrGvYV1tMrinRFt5MmjY0Pu6reHf
        z58BwpYu/2EU48USoLn3sn3yfBsqv2h7gSizPf9KUsCSG45zKfUEhgyK/ndqcie4I+ReEoFZW4vvS
        iPq2QvZ5nC/GDysr32W8qH0y2Mn9DQel08yZHH7Jv3NaAbWh3maSahzaLd2A0C3MIScnDqf+hBjc+
        jd9olRcgADBhr2TVQtoNF4ttUR3/OOM3+9QDCkstZDIR/GBBeWnyTqL2/NJuyodpi7Px6zeehipU7
        8Spz999GsZRk/FLLlFqO/qwcKRE7AjFT6D8nRjMndfFloQMdWckBQN8aE4sRIICw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pZUVp-00EIRM-0F;
        Tue, 07 Mar 2023 11:25:41 +0100
Message-ID: <3b9477e9bf68c2c17b06534140280f400c42096b.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/3] wifi: nl80211: Add support for randomizing TA of
 auth and deauth frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 07 Mar 2023 11:25:39 +0100
In-Reply-To: <20230112012415.167556-2-quic_vjakkam@quicinc.com>
References: <20230112012415.167556-1-quic_vjakkam@quicinc.com>
         <20230112012415.167556-2-quic_vjakkam@quicinc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Applied this one, FWIW.

johannes
