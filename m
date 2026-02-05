Return-Path: <linux-wireless+bounces-31595-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OjzIfPChGk45QMAu9opvQ
	(envelope-from <linux-wireless+bounces-31595-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 17:18:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5BF5202
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 17:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 714503003D2C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311043635E;
	Thu,  5 Feb 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="IYc1vsDB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BC393DF5
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308336; cv=none; b=ecM1zI5VxcwC6Fn668Yvd+bxyFNH0jmFEmI1f93B2+Vi/UrsbYwm0/gbrKkl89pJ2/mASNZ55DFkcAFoDpThfogOj/A71V88HWQQRntg2CTvT4x43N8Hwwd/cUx/AydJmi36IlY71zuav6kXubc05fgxXOvxspIbyzw/xy1pXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308336; c=relaxed/simple;
	bh=nBhLpOLw9Y0D+AOCq6DUbSqpqHe5+6wQrvhoJxQufz0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=ds0wSAs7EauVkqBxGdD9j4wkIhtRQcrYWNWSE/xw9rthME0u/HIIleOYMxkNYe4i+6gKgFsmGsgUwfFMxpcA+tR9Q0CC9wY81zC2+ivzGjKnTkacY44z9IX18G8AO7xGxXN8C1uJUKgt4AnljyG0xxzY4/F5P7i4pGXLmYJBBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=IYc1vsDB; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 78E2F108E25B3
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 17:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770308334;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=nBhLpOLw9Y0D+AOCq6DUbSqpqHe5+6wQrvhoJxQufz0=;
	b=IYc1vsDBOCYFPCq60zeDqdMmE7uOiIchUB0vHKj6pQjdRoj9cOes4ztoxxX0VTl1
	F8xyhTpUpY6jTbtWUco78pkFkmlB2KgAlSa8YQ8Du+Blwmc9H4NDGctu5KkSPNTZ8/Y
	3yB2yQ5LyEtKpq8WliVbp2bPx0djvkyw4EzfYviwxGfPBl3omzF2Aecu/mcCDQLouHv
	HqXrAMfmRVUErHB4C4nMl8ZlnjmTnqF34H2k27NGEg68eZy70c02qdBFtSsMIhwNmqE
	OQCHH90NMDbE+9v1Ye6z9hSdTTwMtBJY4cIMNxDKgyENqQ6U+djrpwvFxClK/UCwTOm
	kCsUwRYmXw==
Date: Thu, 5 Feb 2026 17:18:54 +0100 (CET)
From: bubupersonal@tutamail.com
To: Linux Staging <linux-staging@lists.linux.dev>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <OkiaM3C--F-9@tutamail.com>
Subject: [PATCH] rtw: btcoex: clean up style and documentation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 01470318e6ae3d62ce10645c2cc9fb44f1577512d95fbeeead39fa860176f5cc81ee6f18345bf13b029110000d075436f39689f8ca8c644a41fe76e87399436d27:TurnOnPrivacy!:tutamail
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tutamail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tutamail.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31595-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bubupersonal@tutamail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tutamail.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tutamail.com:email,tutamail.com:dkim,tutamail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2FB5BF5202
X-Rspamd-Action: no action

From: Bubuworks <bubupersonal@tutamail.com>
Date: Thu, 05 Feb 2026 17:25:00 +0200
Subject: [PATCH] rtw: btcoex: clean up style and documentation
Signed-off-by: Bubuworks <bubupersonal@tutamail.com>

<start of patch>
From 0eca95cba2b7bf7b7b4f2fa90734a85fcaa72782 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 4 Feb 2026 10:07:55 -1000
Subject: [PATCH] sched_ext: Short-circuit sched_class operations on dead ta=
sks

7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free=
()
to finish_task_switch()") moved sched_ext_free() to finish_task_switch() an=
d
renamed it to sched_ext_dead() to fix cgroup exit ordering issues. However,
this created a race window where certain sched_class ops may be invoked on
dead tasks leading to failures - e.g. sched_setscheduler() may try to switc=
h a
task which finished sched_ext_dead() back into SCX triggering invalid SCX t=
ask
state transitions.

Add task_dead_and_done() which tests whether a task is TASK_DEAD and has
completed its final context switch, and use it to short-circuit sched_class
operations which may be called on dead tasks.

Fixes: 7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_e=
xt_free() to finish_task_switch()")
Reported-by: Andrea Righi <arighi@nvidia.com>
Link: http://lkml.kernel.org/r/20260202151341.796959-1-arighi@nvidia.com
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
kernel/sched/ext.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
1 file changed, 48 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8f6d8d7f895c..1a5ead4a476e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -194,6 +194,7 @@ MODULE_PARM_DESC(bypass_lb_intv_us, "bypass load balanc=
e interval in microsecond
#include <trace/events/sched_ext.h>

static void process_ddsp_deferred_locals(struct rq *rq);
+static bool task_dead_and_done(struct task_struct *p);
static u32 reenq_local(struct rq *rq);
static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
@@ -2618,6 +2619,9 @@ static void set_cpus_allowed_scx(struct task_struct *=
p,

set_cpus_allowed_common(p, ac);

+=09if (task_dead_and_done(p))
+=09=09return;
+
/*
* The effective cpumask is stored in @p->cpus_ptr which may temporarily
* differ from the configured one in @p->cpus_mask. Always tell the bpf
@@ -3033,10 +3037,45 @@ void scx_cancel_fork(struct task_struct *p)
percpu_up_read(&scx_fork_rwsem);
}

+/**
+ * task_dead_and_done - Is a task dead and done running?
+ * @p: target task
+ *
+ * Once sched_ext_dead() removes the dead task from scx_tasks and exits it=
, the
+ * task no longer exists from SCX's POV. However, certain sched_class ops =
may be
+ * invoked on these dead tasks leading to failures - e.g. sched_setschedul=
er()
+ * may try to switch a task which finished sched_ext_dead() back into SCX
+ * triggering invalid SCX task state transitions and worse.
+ *
+ * Once a task has finished the final switch, sched_ext_dead() is the only=
 thing
+ * that needs to happen on the task. Use this test to short-circuit sched_=
class
+ * operations which may be called on dead tasks.
+ */
+static bool task_dead_and_done(struct task_struct *p)
+{
+=09struct rq *rq =3D task_rq(p);
+
+=09lockdep_assert_rq_held(rq);
+
+=09/*
+=09 * In do_task_dead(), a dying task sets %TASK_DEAD with preemption
+=09 * disabled and __schedule(). If @p has %TASK_DEAD set and off CPU, @p
+=09 * won't ever run again.
+=09 */
+=09return unlikely(READ_ONCE(p->__state) =3D=3D TASK_DEAD) &&
+=09=09!task_on_cpu(rq, p);
+}
+
void sched_ext_dead(struct task_struct *p)
{
unsigned long flags;

+=09/*
+=09 * By the time control reaches here, @p has %TASK_DEAD set, switched ou=
t
+=09 * for the last time and then dropped the rq lock - task_dead_and_done(=
)
+=09 * should be returning %true nullifying the straggling sched_class ops.
+=09 * Remove from scx_tasks and exit @p.
+=09 */
raw_spin_lock_irqsave(&scx_tasks_lock, flags);
list_del_init(&p->scx.tasks_node);
raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
@@ -3062,6 +3101,9 @@ static void reweight_task_scx(struct rq *rq, struct t=
ask_struct *p,

lockdep_assert_rq_held(task_rq(p));

+=09if (task_dead_and_done(p))
+=09=09return;
+
p->scx.weight =3D sched_weight_to_cgroup(scale_load_down(lw->weight));
if (SCX_HAS_OP(sch, set_weight))
SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
@@ -3076,6 +3118,9 @@ static void switching_to_scx(struct rq *rq, struct ta=
sk_struct *p)
{
struct scx_sched *sch =3D scx_root;

+=09if (task_dead_and_done(p))
+=09=09return;
+
scx_enable_task(p);

/*
@@ -3089,6 +3134,9 @@ static void switching_to_scx(struct rq *rq, struct ta=
sk_struct *p)

static void switched_from_scx(struct rq *rq, struct task_struct *p)
{
+=09if (task_dead_and_done(p))
+=09=09return;
+
scx_disable_task(p);
}

--=C2=A0
2.52.0.windows.1
<end of patch>

