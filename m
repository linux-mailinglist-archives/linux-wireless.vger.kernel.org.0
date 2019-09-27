Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82867C003B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfI0Hpd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 03:45:33 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:36223 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbfI0Hpd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 03:45:33 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id DkwPiUjxtz6EADkwSiGF2X; Fri, 27 Sep 2019 09:45:31 +0200
Message-ID: <b6ade5e22bbeafea368a44880d76fac6a152ccc9.camel@tiscali.nl>
Subject: Re: IWL AC 8260, kernel 5.3.*, many kernel WARNING
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Norbert Preining <norbert@preining.info>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilw@linux.intel.com
Date:   Fri, 27 Sep 2019 09:45:22 +0200
In-Reply-To: <20190927010452.b576njhcvgowasf3@burischnitzel.preining.info>
References: <20190927010452.b576njhcvgowasf3@burischnitzel.preining.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLSd/v0oXXaDyBWlM/OHlNG6B9eR7ZhUIMJZhbzbVQW4oq7zdCs9aDbaP8OoUbdBTmA/BBaQGOSxa3pzoy/EA0CfW+cU8eqA2IgpQ4S/RWy+2k/9sWDm
 4PrPlhgReTrvlZPMZiLrg0n4pw9/75ictv5Ldbdu7EMTMB4LzBD/CBhQbpSxbPfXLKAbd3sFi/SZPnphUG1EqDtOV1Vm8UHj5da64ShKS5OgEvvcY9jjQW/L
 U1aVdR/20HQ+1km5/KLZA7C7Ac5Q+GE10yQ7em5YAFo=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Norbert Preining schreef op vr 27-09-2019 om 10:04 [+0900]:
> Sep 27 09:08:35 burischnitzel kernel: WARNING: CPU: 0 PID: 525 at iwl_mvm_rx_umac_scan_complete_notif.cold+0xc/0x13 [iwlmvm]
> [...]
> 
> This repeats a few times (2-4) and then it settles down.
> 
> WIFI works without any problems, though.

This made me check my logs. It turns out that in my current v5.3.1 session
(now in its fifth day) there are 128 of these warnings. In my case the warning
also mentions
    drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874

My previous session (v5.3.0) accumulated 162 of these warnings in about six
days, while the session before that (v5.2.y) showed none.

Just like in Norbert's case, wifi appears to work fine.


Paul Bolle

