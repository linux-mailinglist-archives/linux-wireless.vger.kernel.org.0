Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CD91BF6F1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgD3Lht (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 07:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3Lht (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 07:37:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F8C035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 04:37:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jU7Vh-002b5i-IB; Thu, 30 Apr 2020 13:37:45 +0200
Message-ID: <450305028ea9174998726c1647b08361a88dced5.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/5] cfg80211: add KHz variants of frame RX API
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 30 Apr 2020 13:37:44 +0200
In-Reply-To: <20200430010642.22552-2-thomas@adapt-ip.com>
References: <20200430010642.22552-1-thomas@adapt-ip.com>
         <20200430010642.22552-2-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-04-29 at 18:06 -0700, Thomas Pedersen wrote:
> 
> +#define PR_KHZ(f) KHZ_TO_MHZ((float) f)

You can't use float, sorry.

johannes

