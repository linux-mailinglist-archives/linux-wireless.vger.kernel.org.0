Return-Path: <linux-wireless+bounces-35771-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HDfDLcF9mnTRgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35771-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 16:09:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C73104B2439
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 16:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 184D2300381A
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2026 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1669E1A9F83;
	Sat,  2 May 2026 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2tQqoWD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37C2264D9
	for <linux-wireless@vger.kernel.org>; Sat,  2 May 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730997; cv=pass; b=OTeDXAqpkEULn67OGP3FkBkLu/yOkxoh6YYuo04eDMDbNbQLgjWa8gvCjjksJNNiqmTg4RG26ZyUmb21DWfU/DBixxPoqWYkTbw3SEI/xW9HOEfc/n2m05l3QpU7R5H3IS8vnLfwQmdNaC2Yc7w2lYmq0iz9gHpb5RJKTFSfX+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730997; c=relaxed/simple;
	bh=95lpkySt80iEf1JFJtU6ToZc3Y5J2ZQglR2xTfhy3Z4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bXvHQHtTB1HRTciZgMZjTfOPl23CJtkN48I6woJwsDV1vcsKyjxExDCcFA4WkY7wVpXfkl5bfY1SgzaMWDyyqySrGQfxoP8v6TNFBaxYaycuYDbZ/I3tEFEPhU2lBe6ickplB3CxF3uZS90gasKSGoKQ7tyJUobW2lC12d/fe7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2tQqoWD; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56daced652eso111127e0c.2
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 07:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777730994; cv=none;
        d=google.com; s=arc-20240605;
        b=jmaPIksSksNWh40asBPuNU8hqKk/eT8oFzQwxlMzwfoV2ZIuD8UGMzUtkX+6YzxK6A
         YImqhmeFvvxecVj8Jn5RznfCx4rquwL/LUYOJsU3m3hjPDZgrKErA8CN/5ODeRVTcqSR
         XS32bhaXfQE/MI0yds0SLRN8KEaiSrluXUDh5UQCGeLsLTLkdUfHuHQZndI8+QlSvXwr
         SM/IMuIXgw3hqHD8GlxnlldphSdY72ebcEfbgr0ZkkvPkdc2SvaPGJbHKXMRXzBxFOkS
         kPPK/Lh2xuzKpaU2ql7sQ2/xQz4DxAFiyUh3kPo6KaZfhDDprwgZ/RbDUD8NH/Sqfw8B
         pOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=jHtI/3TU8bFEZT2nRSlj87DddQ+clp+LwaHao6oNTW4=;
        fh=Y4+ttdb+EqpIcDJwQ/sZTpn6zwAwE8scaE+NhCh+XVE=;
        b=ekb02jjQkaSSnDZEIFE+iP16stXX1vKoJObECrwpMlZkPByujlbV+mr9sA/j0rIv7t
         g9Hd+7GTRWXKbLfA4bOKMiF8PjWCYXPMsdPPscMJa1M/xluxkzFcSR05v1CSAsCeXlfd
         NtZSWcmliaQAQ+/kyIp5kCkq8JAAAyHGzJRn3aPQ6O5LHZMmXX6X/Bdm7hISIAWeVlCX
         VDVmIpI+tVRTKS6WjO+Fslsj/MQVjqqdVzYw9VOq2In+1aNmu4Le9t6w07454y43u2ka
         Mv/yQB5NVaxyCxzdl8iUcpjumHUXJ989XDfOV0M/+GlfW6UdX6c9j+H6HDBaeqOuch//
         Fq+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777730994; x=1778335794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jHtI/3TU8bFEZT2nRSlj87DddQ+clp+LwaHao6oNTW4=;
        b=M2tQqoWDlt+uISbm1PC+VTy1sKYdYiaEKU8RPvtXiCfSs/6cX4ACyoj6k0LROMilyF
         NY6YFsutzmr7C4AIf2/3qRztJdG0bCj792ldS6Wycj3PzGTxvKOJxdolxYMS/w9KOQBL
         G4spJ6kVfrJf0i/iUm1k5Uy+OdzkfnNeti/uhNkYrr5HOMgh0+8aFV/2HB2vbRmrI0wV
         OF6dAckoCye/hienfAfpRHQoQoQe+xLEZeeJol1oV2KJtgv6e2C4UoyrxAjqqh9g8/AA
         Qh8a0RwQVloNkZAc3stb36+Pf7dFSZ+2x+suVvRCBn6j7Vp8pWgfgP1h/CZXlBA5yXN0
         i22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777730994; x=1778335794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHtI/3TU8bFEZT2nRSlj87DddQ+clp+LwaHao6oNTW4=;
        b=g2C1/1Jb4bfkY9sCshgM7gAqgYlCaQW4Uy1tGsFEJXD9joAiVE2lhO7N0VALVHCUpt
         8pyezlQFHwqiTHeFHKvz92qXW3yXrl872QRYisaNul9XNrrJ1TTWsSdb18a0B5DfrIbI
         ktDvQdnJT6TyL0PwQpcU4xBOqkfg26P+3CBxXrd6Rz/AjaRI4kuYBI9QTHmKevBGSH2x
         GYZDNJjKJichX10x5jMC0R58NCaIUCo34AFj9LQgAK/cIb6qPib61fALRfnofeXV9h/W
         w3xdrAWiHfBxenuUe9JDYRdRKWiTeUP7PpbRHRHeP1UI0/8UHFEYp27REcd4oSd5kKik
         SruA==
X-Gm-Message-State: AOJu0Yzkc5314VH3WSpshOcW8kUCUitXPONZ4a5qmaJ9aj9etEG2we7e
	qrFRsLLtTvjRxi3bO2waIOsA5I4OHbJ9bSt/wqS+X/ki+JWYnO0RAfGj/phziAsmqLomrS167Ni
	UhoKqObfGn4uFqv4F7bz0NvROYrKISwqQQhVA
X-Gm-Gg: AeBDieu6jGeqRbGaHS5CeCqjWt/mehS8QZS+igsgSpNlXBg9eRdD226xKJeVbEI34QM
	zEp/Fq3KtsmqxWA4JbA1y/tKDip+5+LPT/SqM2/OKBuKaN5UQBWmZxTGEsn+Zb/9mboCoO1Fy8E
	T6QyFmY+W4lrToZiPeB+cfXUVfo09gtQJ3cpZRQIO4MgRFhuC9m+maNhJTCpg4UtTRhIOgnsDqG
	c4DsjCQgJIOWohs/HJMdDXo+jzMdJwo6tyyDTM/ZXPbiIcMi6iVEEcMJsycEp0R6CvNntJyaesY
	EEAHbzrgmqD3VYGwLEJU0euIlUC1qzY=
X-Received: by 2002:a05:6102:548f:b0:5ff:d7be:fdeb with SMTP id
 ada2fe7eead31-62d87d9841fmr540151137.7.1777730994283; Sat, 02 May 2026
 07:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pavitra Jha <jhapavitra98@gmail.com>
Date: Sat, 2 May 2026 19:34:58 +0530
X-Gm-Features: AVHnY4L2l7PMftFucV00Fc7nbIxq4-1l9NHOPEX8_3QegneIZ1VyBcXTKPZ7HXM
Message-ID: <CALFbBicOiAFMK3AsEzG-L7AfWzNyR4HzaN541eqt4_fKSc8aug@mail.gmail.com>
Subject: [SECURITY] wifi: wfx: use-after-destroy of wfx_vif via uncancelled
 work items
To: linux-wireless@vger.kernel.org
Cc: jerome.pouiller@silabs.com, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C73104B2439
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35771-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

Hello,

I am reporting an invalid post-lifetime object access in
drivers/net/wireless/silabs/wfx/ caused by two work items embedded in
struct wfx_vif that may remain queued after mac80211 zeroes the
instance memory following drv_remove_interface().

1. ROOT CAUSE

wfx_remove_interface() cancels beacon_loss_work but not
update_tim_work or tx_policy_upload_work:

  cancel_delayed_work_sync(&wvif->beacon_loss_work); /* only this */
  wdev->vif[wvif->id] =3D NULL;
  mutex_unlock(&wdev->conf_mutex);

The presence of that cancel demonstrates the driver already
acknowledges embedded async work must be flushed during teardown,
but omits the two plain work items below.

After drv_remove_interface() returns, mac80211 zeroes the driver
private area backing wvif in place (net/mac80211/iface.c):

  drv_remove_interface(local, sdata);
  memset(sdata->vif.drv_priv, 0, local->hw.vif_data_size);

A queued work item firing after this memset may dereference zeroed
wvif fields, resulting in invalid memory accesses.

2. UNCANCELLED WORK ITEMS

update_tim_work (sta.c:739)

  Scheduled from sta.c:635, queue.c:293, data_tx.c:406, data_tx.c:539.

  Callback:
    static void wfx_update_tim_work(struct work_struct *work)
    {
        struct wfx_vif *wvif =3D container_of(work, struct wfx_vif,
                                            update_tim_work);
        wfx_update_tim(wvif);
    }

  wfx_update_tim() dereferences wvif fields directly with no mutex
  protection. Execution against zeroed wvif memory may produce
  invalid accesses.

tx_policy_upload_work (data_tx.c:175)

  Scheduled from data_tx.c:306.

  Callback dereferences wvif fields under only cache->lock (a
  per-vif spinlock). Execution against zeroed wvif memory may
  produce invalid accesses.

A tree-wide grep finds no direct cancellation or per-work flush of
either item anywhere in the driver:

  grep -rn "cancel_work_sync.*update_tim\|cancel_work_sync.*tx_policy" \
    drivers/net/wireless/silabs/wfx/
  (no matches)

3. RACE WINDOW

In ieee80211_do_stop():

  sta_info_flush()
    -> __sta_info_destroy_part2()
      -> __sta_info_recalc_tim(sta, true)  /* sta->dead still false */
        -> drv_set_tim()
          -> wfx_set_tim()
            -> schedule_work(&wvif->update_tim_work)  /* QUEUED */

  [wiphy_work_cancel() covers mac80211 own items only]

  drv_remove_interface()
  memset(sdata->vif.drv_priv, 0, ...)     /* wvif zeroed */

  [workqueue fires -> dereference of zeroed wvif -> invalid access]

mac80211 provides no mechanism to flush driver-registered work_struct
items around drv_remove_interface(). Note that sta->dead is set on
the line immediately after __sta_info_recalc_tim() returns, so the
!WARN_ON(sta->dead) gate at sta_info.c:1150 does not suppress
drv_set_tim() during this path.

4. FIX

One candidate fix, consistent with the existing teardown pattern:

  cancel_delayed_work_sync(&wvif->beacon_loss_work);
+ cancel_work_sync(&wvif->update_tim_work);
+ cancel_work_sync(&wvif->tx_policy_upload_work);
  wdev->vif[wvif->id] =3D NULL;

A tree-wide grep finds no direct conf_mutex acquisition in the
callback implementations or their immediate code paths, which is
consistent with placement inside the existing mutex block =E2=80=94 though
indirect acquisition through deeper call chains has not been
exhaustively verified.

5. AFFECTED VERSIONS

  Present in current mainline (Linux 7.0-rc7, confirmed).
  Likely affects older versions back to driver introduction;
  backport range pending verification.
  CONFIG_WFX=3Dy / m

  No fix present in linux-wireless tree as of lore.kernel.org
  search conducted May 2026.

Thanks,
Pavitra Jha
jhapavitra98@gmail.com

